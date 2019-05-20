cd
echo ".dotfiles" >> $HOME/.gitignore
echo "Cloning dotfiles repo.";
git clone --bare https://github.com/Melkster/dotfiles.git $HOME/.dotfiles

function dotfiles {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p $HOME/.dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files.";
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I % sh -c 'mkdir --parents .dotfiles-backup/%; mv % .dotfiles-backup/%;'
  dotfiles checkout
fi;

echo "Configuring repository.";
dotfiles config status.showUntrackedFiles no
dotfiles config --add remote.origin.fetch "refs/heads/*:refs/remotes/origin/*"
dotfiles push --set-upstream origin master

echo "Installing packages in 'pkglist.txt'";
pacman -S yay
yay -S --needed --noconfirm - < .dotfiles/pkglist.txt

echo "Adding npm dependencies";
# sudo npm install -g prettier eslint-plugin-prettier eslint-config-prettier javascript-typescript-langserver # Probably not needed with coc.nvim
sudo npm install -g yarn # For coc.nvim

echo "Creating Vim swap file directories.";
mkdir -p $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo $HOME/.vim/tags # Create Vim directories
chmod +x $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo                 # And make them executable (at least backup needs this)

echo "Installing Vundle and Vundle plugins for Vim";
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +"call coc#util#build()" +"CocInstall coc-syntax coc-tag coc-snippets coc-python coc-java coc-ccls coc-html coc-css coc-prettier coc-highlight coc-json" +qa

pip install --user autopep8 flake8 # For Python linting and autoformatting

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Deja Vu Sans Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
fc-cache
cd -

echo "Removing README.md and setting it to 'assume-unchanged'.";
dotfiles update-index --assume-unchanged $HOME/README.md
rm -f $HOME/README.md

if [[ `cat $HOME/.gitignore 2>/dev/null` = ".dotfiles" ]]; then
  echo "Removing ~/.gitignore."
  rm $HOME/.gitignore
fi

echo "Installing Antigen";
mkdir -p .zsh
curl -L git.io/antigen > .zsh/antigen.zsh

echo "Installing Powerline.";
pip install --user powerline-status
# To remove the vi-mode indicator (because it slows down) mode switching remove
# the block with `"function": "powerline.segments.shell.mode"` from the file
# `~/.local/lib/python3.7/site-packages/powerline/config_files/themes/shell/default.json`


echo "Installing less configuration based on ~/.lesskey";
lesskey

echo "Adding various Gnome settings"
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < .dotfiles/media-keys.dconf
dconf load /org/gnome/desktop/wm/keybindings/ < .dotfiles/keybindings.dconf
dconf load /org/gnome/gnome/shell/extensions < .dotfiles/gnome-extensions.dconf

echo "To change Numix Frost to dark theme run the following:"
echo "sudo mv /usr/share/themes/Numix-Frost/gtk-3.20/gtk-dark.css /usr/share/themes/Numix-Frost/gtk-3.20/gtk.css"

echo "Done."
