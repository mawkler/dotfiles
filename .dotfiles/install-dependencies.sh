#!/bin/sh

###
## Installs programs and configurations that require root privileges
###

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

USER_HOME=$(eval echo ~${SUDO_USER})

if type pacman &> /dev/null; then
  echo "Installing packages in 'pkglist.txt'";
  yes | sudo pacman -S yay
  sudo -u $SUDO_USER yay -S --needed --noconfirm - < $USER_HOME/.dotfiles/pkglist.txt
fi

if type cargo &> /dev/null; then
  echo "Installing Cargo packages in 'cargo-pkglist.txt'";
  xargs cargo install < ~/.dotfiles/cargo-pkglist.txt
fi

if type tmux && [ -x /usr/share/tmux-plugin-manager/bin/install_plugins ] &> /dev/null; then
  echo "Installing Tmux plugins"
  /usr/share/tmux-plugin-manager/bin/install_plugins
fi

echo "Adding npm dependencies";
sudo npm install -gy prettier

echo "Running install-configuration.sh"
sudo -i -u $SUDO_USER $USER_HOME/.dotfiles/install-configuration.sh

# From https://www.dannyguo.com/blog/remap-caps-lock-to-escape-and-control/
if type caps2esc &> /dev/null; then
  echo "Installing caps2esc"
  echo '- JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]' > /etc/udevmon.yaml
  sudo systemctl enable udevmon
else
  echo "caps2esc not installed."
fi

# From https://dev.to/darksmile92/get-emojis-working-on-arch-linux-with-noto-fonts-emoji-2a9
echo "Setting up Noto Emoji font"
sudo pacman -S noto-fonts-emoji --needed
echo '<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <alias>
   <family>sans-serif</family>
   <prefer>
     <family>Noto Sans</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
     <family>DejaVu Sans</family>
   </prefer>
 </alias>

 <alias>
   <family>serif</family>
   <prefer>
     <family>Noto Serif</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
     <family>DejaVu Serif</family>
   </prefer>
 </alias>

 <alias>
  <family>monospace</family>
  <prefer>
    <family>Noto Mono</family>
    <family>Noto Color Emoji</family>
    <family>Noto Emoji</family>
    <family>DejaVu Sans Mono</family>
   </prefer>
 </alias>
</fontconfig>
' > /etc/fonts/local.conf
# ' > ~/.config/fontconfig/fonts.conf # If the privous line doesn't work
fc-cache
echo "Noto Emoji Font installed! You may need to restart applications like Chrome. If Chrome displays no symbols or no letters, your default font contains emojis."
