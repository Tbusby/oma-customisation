#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERRIDES_LUA="$SCRIPT_DIR/hypr-customisations.lua"
HYPRLAND_LUA="$HOME/.config/hypr/hyprland.lua"
HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
REQUIRE_LINE='require("hypr.customisations")'

# Check if overrides config exists
if [ ! -f "$OVERRIDES_LUA" ]; then
    echo "Overrides config not found at $OVERRIDES_LUA"
    exit 1
fi

# New-style Lua config (Omarchy quattro+)
if [ -f "$HYPRLAND_LUA" ]; then
    echo "Detected Lua-based Hyprland config at $HYPRLAND_LUA"

    # Install the overrides module
    cp "$OVERRIDES_LUA" "$HOME/.config/hypr/customisations.lua"
    echo "Installed overrides to ~/.config/hypr/customisations.lua"

    # Add the require line to hyprland.lua if not already present
    if grep -Fq "$REQUIRE_LINE" "$HYPRLAND_LUA"; then
        echo "Overrides loader already present in $HYPRLAND_LUA"
    else
        echo "Adding overrides loader to $HYPRLAND_LUA"
        echo "" >> "$HYPRLAND_LUA"
        echo "$REQUIRE_LINE" >> "$HYPRLAND_LUA"
        echo "Overrides loader added successfully"
    fi

    # Back up stale pre-Lua .conf files that now have a Lua counterpart
    backup_dir=""
    for section in autostart bindings envs input looknfeel monitors; do
        if [ -f "$HOME/.config/hypr/$section.conf" ] && [ -f "$HOME/.config/hypr/$section.lua" ]; then
            backup_dir="${backup_dir:-$HOME/.config/hypr/conf-backup.$(date +%s)}"
            mkdir -p "$backup_dir"
            mv "$HOME/.config/hypr/$section.conf" "$backup_dir/"
        fi
    done
    if [ -f "$HYPRLAND_CONF" ]; then
        backup_dir="${backup_dir:-$HOME/.config/hypr/conf-backup.$(date +%s)}"
        mkdir -p "$backup_dir"
        mv "$HYPRLAND_CONF" "$backup_dir/"
    fi
    if [ -n "$backup_dir" ]; then
        echo "Backed up stale .conf files to $backup_dir"
    fi

    echo "Hyprland overrides setup complete!"

    # Reload Hyprland if a session is running
    if command -v hyprctl >/dev/null 2>&1 && hyprctl systeminfo >/dev/null 2>&1; then
        hyprctl reload >/dev/null 2>&1 || true
        if hyprctl configerrors 2>/dev/null | grep -q .; then
            echo "WARNING: Hyprland reported config errors:"
            hyprctl configerrors
        else
            echo "Hyprland reloaded with no config errors"
        fi
    else
        echo "No running Hyprland session - config will load on next login"
    fi

# Legacy .conf-based config (pre-Lua)
elif [ -f "$HYPRLAND_CONF" ]; then
    echo "Detected legacy .conf-based Hyprland config at $HYPRLAND_CONF"
    echo "This machine uses the pre-Lua config format, but this repo's"
    echo "customisations are written for Omarchy's Lua config (quattro+)."
    echo "Run 'omarchy update' to migrate to the Lua config first, then re-run this script."
    exit 1

else
    echo "Hyprland config not found at $HYPRLAND_LUA or $HYPRLAND_CONF"
    echo "Please install hyprland first"
    exit 1
fi
