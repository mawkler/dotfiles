# This is the Windows-version

# Installation
To clone and set everything up, run the following:
```sh
echo 'alias dotfiles="/mingw64/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> .bashrc
echo 'alias dot="dotfiles"' >> .bashrc
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/Melkster/dotfiles.git $HOME/.dotfiles
dotfiles checkout
dotfiles config status.showUntrackedFiles no
dotfiles config --add remote.origin.fetch "refs/heads/*:refs/remotes/origin/*"
dotfiles push --set-upstream origin windows
mkdir -p $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/undo $HOME/.vim/tags
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qa
```

If you have `pacman` installed and want to install all dependencies and additional programs listed [here](.dotfiles/pkglist.txt), run this:

```sh
curl -s https://raw.githubusercontent.com/Melkster/dotfiles/master/.dotfiles/install-dependencies.sh | sudo bash
curl -s https://raw.githubusercontent.com/Melkster/dotfiles/master/.dotfiles/install-dotfiles.sh | bash
```

# Dependencides

- [git](https://git-scm.com/) (obviously)
- [python](https://www.python.org/downloads/) for some Vim plugins
- [powerline](https://github.com/powerline/powerline) and [pip](https://pypi.org/project/pip/) (for installing powerline-status for ZSH)
- [npm](https://www.npmjs.com/) (for some Vim dependencies)
