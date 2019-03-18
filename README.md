# This is the Windows-version

# Installation
To clone and set everything up, run the following:
```sh
alias dotfiles="/mingw64/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/Melkster/dotfiles.git $HOME/.dotfiles
dotfiles checkout
dotfiles config status.showUntrackedFiles no
dotfiles config --add remote.origin.fetch "refs/heads/*:refs/remotes/origin/*"
dotfiles push --set-upstream origin master
mkdir -p $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo $HOME/.vim/tags
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qa
```
# Dependencides
 - [git](https://git-scm.com/) (obviously)
 - [powerline](https://github.com/powerline/powerline) and [pip](https://pypi.org/project/pip/) (for installing powerline-status)
 - [ctags](https://ctags.io/) (for Vim)
 - [npm](https://www.npmjs.com/) (for some Vim dependencies)
