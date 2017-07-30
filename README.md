# dotfiles

To clone and set everything up, run the following script, based on [this article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/):

```
git clone --bare https://github.com/Melkster/dotfiles.git $HOME/.dotfiles

function dotfiles {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files.";
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no

mkdir ~/.vim/.backup ~/.vim/.swp ~/.vim/.undo #Create vim swap file directories

pip install https://github.com/Lokaltog/powerline/tarball/develop #Install powerline
```
