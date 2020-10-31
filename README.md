# This is the Windows-version

# Installation

To clone and set everything up, run the following bash script:

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
powershell -Command 'md ~\.vim\autoload
$uri = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))'
vim +PlugInstall +qa
```

# Dependencides

- [git](https://git-scm.com/) (obviously)
- [python](https://www.python.org/downloads/) for some Vim plugins
- [npm](https://www.npmjs.com/) (for some Vim dependencies)
