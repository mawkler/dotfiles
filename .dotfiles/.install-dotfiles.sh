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
echo "Hiding untracked files.";
dotfiles config status.showUntrackedFiles no

echo "Creating Vim swap file directories.";
mkdir -p $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo    #Create Vim swap file directories
chmod +x $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo #And make them executable (at least backup needs this)

echo "Installing Vundle and Vundle plugins for Vim";
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qa

echo "Removing README.md and setting it to 'assume-unchanged'.";
dotfiles update-index --assume-unchanged $HOME/README.md
rm -f $HOME/README.md

if [[ `cat $HOME/.gitignore 2>/dev/null` = ".dotfiles" ]]; then
  echo "Removing ~/.gitignore."
  rm $HOME/.gitignore
fi

echo "Installing Antigen";
mkdir .zsh
curl -L git.io/antigen > .zsh/antigen.zsh

echo "Installing Powerline.";
pip install --user powerline-status

echo "Adding npm dependencies";
sudo npm install -g prettier eslint-plugin-prettier eslint-config-prettier javascript-typescript-langserver

echo "Installing less configuration based on ~/.lesskey";
lesskey

echo "To change Numix Frost to dark theme run the following:"
echo "sudo mv /usr/share/themes/Numix-Frost/gtk-3.20/gtk-dark.css /usr/share/themes/Numix-Frost/gtk-3.20/gtk.css"

echo "Done."
