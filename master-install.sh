#!/usr/bin/env bash
# Configure Omarchy after a fresh install

omarchy-theme-set tokyo-night

# Install all custom packages
yay -Sc
. ./install-shellhelpers.sh
. ./install-stow.sh
. ./install-dotfiles.sh
. ./install-hypr-customisations.sh
. ./install-zsh.sh
. ./install-kitty.sh
. ./install-firefox.sh
. ./install-thunderbird.sh 
. ./install-restic.sh
