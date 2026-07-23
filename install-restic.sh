#!/usr/bin/env bash
# Install firefox

yay -S --noconfirm --needed restic

if [ -d "/mnt/shared/backups"]; then
  export RESTIC_REPOSITORY='/mnt/shared/backups/$HOST'
else
  echo "-- /mnt/shared/backups does not exists please check NFS mount"
fi
