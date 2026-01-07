#!/bin/bash

# 1. Install official packages
echo "Installing official packages..."
sudo pacman -S --needed - < official_pkgs.txt

# 2. Install AUR helper (if not present)
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# 3. Install AUR packages
echo "Installing AUR packages..."
yay -S --needed - < aur_pkgs.txt

# 4. Handle manual (curl) installs
echo "Installing starship via curl..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Add other manual installs here
# Example:
# curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Setup complete! Don't forget to restore your dotfiles."
