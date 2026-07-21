#!/usr/bin/env bash
# Install firefox

yay -S --noconfirm --needed firefox

xdg-settings set default-web-browser firefox.desktop
