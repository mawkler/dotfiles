cd
echo ".dotfiles" >> $HOME/.gitignore

echo "Cloning dotfiles repo.";
yes | git clone --bare git@github.com:Melkster/dotfiles.git $HOME/.dotfiles 2> /dev/null
if [ $? -ne 0 ]; then # If cloning with SSH doesn't work, use HTTP
  git clone --bare https://github.com/Melkster/dotfiles.git $HOME/.dotfiles
fi

function dotfiles {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p $HOME/.dotfiles-backup
dotfiles checkout 2> /dev/null
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files.";
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I % sh -c 'mkdir --parents .dotfiles-backup/%; mv % .dotfiles-backup/%;'
fi;

echo "Configuring repository.";
dotfiles config status.showUntrackedFiles no
dotfiles config --add remote.origin.fetch "refs/heads/*:refs/remotes/origin/*"
dotfiles config --local push.default current # Should set upstream like `dotfiles push --set-upstream origin master` does, but without using `push`?

echo "Creating Vim swap file directories.";
mkdir -p $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo $HOME/.vim/tags # Create Vim directories
chmod +x $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo                 # And make them executable (at least backup needs this)

echo "Installing Vundle and Vundle plugins for Vim";
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
if type nvim &> /dev/null; then
  nvim +PluginInstall +"call coc#util#install()" +qa 2> /dev/null
else
  yes | vim +PluginInstall +"call coc#util#install()" +qa 2> /dev/null
fi

pip install --user autopep8 flake8 # For Python linting and autoformatting
pip install --user neovim

mkdir -p ~/.local/share/fonts
# cd ~/.local/share/fonts && curl -fLo "Deja Vu Sans Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
rm DejaVuSansMono.zip
fc-cache -fv
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

touch ~/.fzf_history # History file required by fzf-configuration in ~/.zshrc

echo "Installing Powerline.";
pip install --user powerline-status
# To remove the vi-mode indicator (because it slows down) mode switching remove
# the block with `"function": "powerline.segments.shell.mode"` from the file
# `~/.local/lib/python3.7/site-packages/powerline/config_files/themes/shell/default.json`

echo "Installing less configuration based on ~/.lesskey";
lesskey

if [ $XDG_CURRENT_DESKTOP == "GNOME" ]; then
  echo "Adding various Gnome settings"
  dconf load /org/gnome/settings-daemon/plugins/media-keys/ < .dotfiles/media-keys.dconf
  dconf load /org/gnome/desktop/wm/keybindings/ < .dotfiles/keybindings.dconf
  dconf load /org/gnome/shell/extensions/ < .dotfiles/gnome-extensions.dconf
  dconf load /org/gnome/desktop/interface/ < .dotfiles/interface.dconf

  echo "To change Numix Frost to dark theme run the following:"
  echo "sudo mv /usr/share/themes/Numix-Frost/gtk-3.20/gtk-dark.css /usr/share/themes/Numix-Frost/gtk-3.20/gtk.css"
fi

echo "To change shell to ZSH, run 'chsh -s $(which zsh) $USER'."

echo "Done."
