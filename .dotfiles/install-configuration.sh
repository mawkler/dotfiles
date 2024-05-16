#!/bin/sh

###
## Installs configurations that don't require root privileges
###

echo {} > $HOME/.cspell.json

echo "Installing Python dependencies for Neovim"
pip install --user neovim

echo "Installing Antigen"
mkdir -p .zsh
curl -L git.io/antigen > .zsh/antigen.zsh

touch $HOME/.fzf_history # History file required by fzf-configuration in ~/.zshrc

echo "Installing less configuration based on ~/.lesskey"
lesskey

if [[ $XDG_CURRENT_DESKTOP == "GNOME" ]]; then
	echo "Adding various Gnome settings"
	dconf load /org/gnome/settings-daemon/plugins/media-keys/ < .dotfiles/media-keys.dconf
	dconf load /org/gnome/desktop/wm/keybindings/ < .dotfiles/keybindings.dconf
	dconf load /org/gnome/shell/extensions/ < .dotfiles/gnome-extensions.dconf
	dconf load /org/gnome/shell/window-switcher/ < .dotfiles/window-switcher.dconf
	dconf load /org/gnome/shell/extensions/paperwm/keybindings/ < .dotfiles/paperwm-keybindings.dconf
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

echo "Generating bitwarden ZSH completion"
if [ -x "$(command -v bw)" ]; then
	eval "$(bw completion --shell zsh); compdef _bw bw;"
fi

# ~/.profile doesn't seem to get sourced on X
echo "Symlinking /etc/profile.d/profile.sh to ~/.profile"
ln -s ~/.profile /etc/profile.d/profile.sh

echo "Setting up Spicetify"
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify
spicetify backup apply enable-devtools
spicetify config custom_apps marketplace
spicetify apply
# Spicetify extensions
# - Hazy
# - keyboard shortcut
# - Full Screen

echo "To change shell to ZSH, run 'chsh -s $(which zsh) $USER'."
