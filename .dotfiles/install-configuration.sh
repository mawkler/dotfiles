#!/bin/sh

###
## Installs configurations that don't require root privileges
###

echo "Installing vim-plug and plugins for Vim";
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if type nvim &> /dev/null; then
  nvim +PlugInstall +qa 2> /dev/null
else
  vim +PlugInstall +qa 2> /dev/null
fi

pip install --user autopep8 flake8 # For Python linting and autoformatting
pip install --user neovim

echo "Installing Antigen";
mkdir -p .zsh
curl -L git.io/antigen > .zsh/antigen.zsh

touch $HOME/.fzf_history # History file required by fzf-configuration in ~/.zshrc

echo "Installing onedark theme for bat"
mkdir -p "$(bat --config-dir)/themes"
cp $HOME/.dotfiles/base16-onedark.tmTheme "$(bat --config-dir)/themes"
bat cache --build # Update the binary cache

echo "Installing Powerline.";
pip install --user powerline-status
# To remove the vi-mode indicator (because it slows down) mode switching remove
# the block with `"function": "powerline.segments.shell.mode"` from the file
# `~/.local/lib/python3.7/site-packages/powerline/config_files/themes/shell/default.json`

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

echo "To change shell to ZSH, run 'chsh -s $(which zsh) $USER'."
