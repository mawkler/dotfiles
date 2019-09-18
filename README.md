# Installation
To clone and set everything up, run the following:

```sh
sudo bash <(wget -qO- https://raw.githubusercontent.com/Melkster/dotfiles/master/.dotfiles/install-dotfiles.sh)

```

which downloads and runs [this script](https://raw.githubusercontent.com/Melkster/dotfiles/master/.dotfiles/install-dotfiles.sh) which is based on [this article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

The following is basically what the script does, plus backing up previous dotfiles, adding Vim swap file directories, installing Powerline and removing some unwanted files:
```sh
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/Melkster/dotfiles.git $HOME/.dotfiles
dotfiles checkout
```
# Dependencides
 - [git](https://git-scm.com/) (obviously)
 - [python](https://www.python.org/downloads/) for some Vim plugins
 - [powerline](https://github.com/powerline/powerline) and [pip](https://pypi.org/project/pip/) (for installing powerline-status for ZSH)
 - [npm](https://www.npmjs.com/) (for some Vim dependencies)
