if type pacman &> /dev/null; then
  echo "Installing packages in 'pkglist.txt'";
  yes | sudo -i -u $USER pacman -S yay
  sudo -i -u $USER yay -S --needed --noconfirm - < ~/.dotfiles/pkglist.txt
fi

echo "Adding npm dependencies";
sudo -i -u $USER npm install -gy yarn # For coc.nvim
