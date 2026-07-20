#!/usr/bin/env bash
# Install webapps

# gmail
cat > "$HOME/.local/share/applications/gmail-webapp.desktop" <<EOF
[Desktop Entry]
Version=1.0
Name=gmail
Comment=gmail
Exec=omarchy-launch-webapp https://mail.google.com/mail/u/0/#inbox
Terminal=false
Type=Application
Icon=/home/$HOME/.local/share/applications/icons/gmail.png
StartupNotify=true
EOF
