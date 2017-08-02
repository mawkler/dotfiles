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
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
echo "Hiding untracked files.";
dotfiles config status.showUntrackedFiles no

echo "Creating Vim swap file directories.";
mkdir $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo    #Create Vim swap file directories
chmod +x $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo #And make them executable (at least backup needs this)

echo "Removing README.md and setting it to 'assume-unchanged'.";
dotfiles update-index --assume-unchanged $HOME/README.md
rm $HOME/README.md

if [[ `cat $HOME/.gitignore 2>/dev/null` = ".dotfiles" ]]; then
  echo "Removing ~/.gitignore."
  rm $HOME/.gitignore
fi

echo "Installing Powerline.";
pip install https://github.com/Lokaltog/powerline/tarball/develop #Install powerline

echo "Done."
