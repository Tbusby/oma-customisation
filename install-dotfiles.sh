#!/bin/bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/tbusby/dotfiles"
REPO_NAME="dotfiles"

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "removing old configs"
  rm -rf ~/.config/starship.toml
  rm -rf ~/.config/hypr/hypridle.conf
  rm -rf ~/.config/walker/config.toml
  rm -rf ~/.config/xdg-terminals.list
  rm -rf ~/.config/kitty/current-theme.conf
  rm -rf ~/.config/kitty/kitty.conf
  rm -rf ~/.config/xdg-terminals.list
  rm -rf ~/.config/zsh/aliases.zsh
  rm -rf ~/.config/zsh/bindings.zsh
  rm -rf ~/.config/zsh/fzf.zsh
  rm -rf ~/.config/zsh/plugins.zsh
  rm -rf ~/.config/zsh/prompt.zsh
  rm -rf ~/.config/zsh/.zshrc
  rm -rf ~/.config/zsh/.zshenv
  rm -rf ~/.config/waybar/config.jsonc
  rm -rf ~/.config/waybar/style.css
  rm -rf ~/.config/yay/config.json

  cd "$REPO_NAME"
  stow -t ~ hyprland
  stow -t ~ walker
  stow -t ~ kitty
  stow -t ~ zsh
  stow -t ~ waybar
  stow -t ~ yay
else
  echo "Failed to clone the repository."
  exit 1
fi

cd "$ORIGINAL_DIR"
