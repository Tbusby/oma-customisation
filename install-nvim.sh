#!/usr/bin/env bash
# nvim is already installed but apply my custom config

# start with a blank state
yay -Rns --noconfirm neovim
yay -Rns --noconfirm omarchy-nvim

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# ensure dirs exist
mkdir -p ~/.config/nvim

# install nvim and configs deps
yay -S --noconfirm --needed neovim tree-sitter-cli go lua-jsregexp git ripgrep fzf fd

