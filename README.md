My Neovim configuration is available at [mawkler/nvim](https://github.com/mawkler/nvim/)

# Installation

**Without `sudo`:**

To clone the dotfiles and set them up, run the following:

```sh
curl -s https://raw.githubusercontent.com/melkster/dotfiles/master/.dotfiles/install-dotfiles.sh | bash
```

which downloads and runs [this script](https://raw.githubusercontent.com/melkster/dotfiles/master/.dotfiles/install-dotfiles.sh) which is based on [this article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

**With `sudo` and `pacman`:**

If you have `pacman` installed and also want to install all dependencies and additional programs listed [here](.dotfiles/pkglist.txt) as well as some system configurations, run this:

```sh
dotfiles_url=https://raw.githubusercontent.com/melkster/dotfiles/master/.dotfiles/
curl -s ${dotfiles_url}install-dotfiles.sh | bash
curl -s ${dotfiles_url}install-dependencies.sh | sudo bash
```

# Dependencides

These dotfiles assume that you're on Unix. For Windows, check out the [Windows branch](https://github.com/melkster/dotfiles/tree/windows) (isn't updated that often though).

- [git](https://git-scm.com/) (obviously)
- [python](https://www.python.org/downloads/) for some Neovim plugins
- [go](https://golang.org/) (for [vim-hexokinase](https://github.com/RRethy/vim-hexokinase) )
