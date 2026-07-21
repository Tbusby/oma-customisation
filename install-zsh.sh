#!/usr/bin/env bash
# Install zsh

yay -S --noconfirm --needed zsh
chsh -s $(which zsh)

# ensure dirs exist
mkdir ~/.config/zsh
mkdir ~/.local/state/zsh
mkdir ~/.cache/zsh 

# copy zshenv to /etc/zsh tells zsh where to find configs locally
echo "Supdo pass to copy zshenv to /etc/zsh"
sudo cp zshenv /etc/zsh/

