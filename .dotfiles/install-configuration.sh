#!/bin/sh

###
## Installs configurations that don't require root privileges
###

echo "Installing packer.nvim and Neovim plugins";
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall'

pip install --user autopep8 flake8 # For Python autoformatting and linting
pip install --user neovim

echo "Installing Antigen";
mkdir -p .zsh
curl -L git.io/antigen > .zsh/antigen.zsh

touch $HOME/.fzf_history # History file required by fzf-configuration in ~/.zshrc

echo "Installing less configuration based on ~/.lesskey";
lesskey

if [[ $XDG_CURRENT_DESKTOP == "GNOME" ]]; then
  echo "Adding various Gnome settings"
  dconf load /org/gnome/settings-daemon/plugins/media-keys/ < .dotfiles/media-keys.dconf
  dconf load /org/gnome/desktop/wm/keybindings/ < .dotfiles/keybindings.dconf
  dconf load /org/gnome/shell/extensions/ < .dotfiles/gnome-extensions.dconf
  dconf load /org/gnome/shell/window-switcher/ < .dotfiles/window-switcher.dconf
  dconf load /org/gnome/desktop/interface/ < .dotfiles/interface.dconf
  dconf load /org/gnome/mutter/keybindings/ < .dotfiles/mutter-keybindings.dconf

  echo "To change Numix Frost to dark theme run the following:"
  echo "sudo mv /usr/share/themes/Numix-Frost/gtk-3.20/gtk-dark.css /usr/share/themes/Numix-Frost/gtk-3.20/gtk.css"
fi

echo "Installing FiraCode with stylistic set"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/melkster/dotfiles/blob/master/.local/share/fonts/OTF/FiraCode-Regular-ss01-ss02-ss03-ss04-ss05-zero.otf
fc-cache -fv
cd -

echo "To change shell to ZSH, run 'chsh -s $(which zsh) $USER'."
