# Installation
To clone and set everything up, run [this script](.dotfiles/.install-dotfiles.sh) based on [this article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

The following is basically what the script does, plus backing up previous dotfiles, adding Vim swap file directories, installing Powerline and removing some unwanted files:
```sh
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/Melkster/dotfiles.git $HOME/.dotfiles
dotfiles checkout
```
# Dependencides
 - git (obviously)
 - powerline
 - pip (for installing powerline-status)
 - npm (for some Vim dependencies)
