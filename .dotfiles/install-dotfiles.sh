#!/bin/sh

###
## Downloads and installs dotfiles from github.com/Melkster/dotfiles
###

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

echo "Removing README.md and setting it to 'assume-unchanged'.";
dotfiles update-index --assume-unchanged $HOME/README.md
rm -f $HOME/README.md

if [[ `cat $HOME/.gitignore 2>/dev/null` = ".dotfiles" ]]; then
  echo "Removing ~/.gitignore."
  rm $HOME/.gitignore
fi

echo "Done."
