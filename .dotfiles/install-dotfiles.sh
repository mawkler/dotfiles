#!/bin/sh

###
## Downloads and installs dotfiles from github.com/mawkler/dotfiles
###

cd
echo ".dotfiles" >> $HOME/.gitignore

echo "Cloning dotfiles repo."
yes | git clone --bare https://github.com/mawkler/dotfiles.git $HOME/.dotfiles 2> /dev/null

function dotfiles {
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

backup_dir="$HOME/.dotfiles-backup/"

mkdir -p $backup_dir
dotfiles checkout 2> /dev/null
if [ $? = 0 ]; then
  echo "Checked out dotfiles."
else
  echo "Backing up pre-existing dotfiles."
  files_to_backup=`dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'}`
  echo $files_to_backup | xargs -n 1 | xargs -I {} sh -c 'mkdir -p ${2}$(dirname $1); mv $1 $2$1' _ {} $backup_dir
  dotfiles checkout
  echo "Checked out dotfiles. Pre-existing files backed up to $backup_dir."
fi

echo "Configuring repository."
dotfiles config status.showUntrackedFiles no
dotfiles config --add remote.origin.fetch "refs/heads/*:refs/remotes/origin/*"
dotfiles config --local push.default current # Should set upstream like `dotfiles push --set-upstream origin master` does, but without using `push`?

echo "Removing README.md and setting it to 'assume-unchanged'."
dotfiles update-index --assume-unchanged $HOME/README.md
rm -f $HOME/README.md

if [[ `cat $HOME/.gitignore 2>/dev/null` = ".dotfiles" ]]; then
  echo "Removing ~/.gitignore."
  rm $HOME/.gitignore
fi

echo "Cloning nvim configuration from mawkler/nvim"
git clone https://github.com/mawkler/nvim.git $HOME/.config/nvim/

echo "Done."
