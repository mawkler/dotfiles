if type pacman &> /dev/null; then
  echo "Installing packages in 'pkglist.txt'";
  pacman -S yay
  yay -S --needed --noconfirm - < .dotfiles/pkglist.txt
fi

echo "Adding npm dependencies";
npm install -gy yarn # For coc.nvim
