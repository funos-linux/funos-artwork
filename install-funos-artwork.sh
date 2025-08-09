#!/bin/bash

# ==========================================================
# FunOS Artwork Installer
# Installs wallpapers, JWM themes, and updates themes-list.
# Supports both interactive and non-interactive mode.
# ==========================================================

# --- Variables ---
REPO_URL="https://github.com/funos-linux/funos-artwork.git"
TEMP_DIR="/tmp/funos-artwork"
WALLPAPER_DEST="/opt/artwork/wallpaper"
JWM_THEME_DEST="$HOME/.config/jwm/themes"
JWM_CONFIG_DEST="$HOME/.config/jwm"
THEMES_LIST_FILE="$JWM_CONFIG_DEST/themes-list"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d%H%M%S)"
NON_INTERACTIVE=false

# --- Colors ---
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# --- Functions ---
msg() { echo -e "${GREEN}✔${RESET} $1"; }
warn() { echo -e "${YELLOW}⚠${RESET} $1"; }
error() { echo -e "${RED}✖${RESET} $1"; }

# --- Arguments ---
if [[ "$1" == "--non-interactive" ]]; then
    NON_INTERACTIVE=true
    msg "Running in non-interactive mode."
fi

echo "Downloading FunOS artwork files..."

# Clean temp dir
rm -rf "$TEMP_DIR"

# Clone repository
if ! git clone "$REPO_URL" "$TEMP_DIR"; then
    error "Failed to clone repository. Check your internet connection."
    exit 1
fi
msg "Repository downloaded to $TEMP_DIR"

# --- Install Wallpapers ---
if [[ -d "$TEMP_DIR/wallpapers" && "$(ls -A "$TEMP_DIR/wallpapers")" ]]; then
    echo "Installing wallpapers to $WALLPAPER_DEST..."
    sudo mkdir -p "$WALLPAPER_DEST"
    sudo cp -v "$TEMP_DIR/wallpapers/"* "$WALLPAPER_DEST"
    msg "Wallpapers installed."
else
    warn "No wallpapers found in repository."
fi

# --- Install JWM Themes ---
if [[ -d "$TEMP_DIR/jwm-themes" && "$(ls -A "$TEMP_DIR/jwm-themes")" ]]; then
    echo "Installing JWM themes to $JWM_THEME_DEST..."
    mkdir -p "$JWM_THEME_DEST"
    cp -rv "$TEMP_DIR/jwm-themes/"* "$JWM_THEME_DEST"
    msg "JWM themes installed."
else
    warn "No JWM themes found in repository."
fi

# --- Backup and Replace themes-list ---
mkdir -p "$JWM_CONFIG_DEST"
if [[ -f "$THEMES_LIST_FILE" ]]; then
    if $NON_INTERACTIVE; then
        cp -v "$THEMES_LIST_FILE" "$THEMES_LIST_FILE$BACKUP_SUFFIX"
        msg "Backed up themes-list to $THEMES_LIST_FILE$BACKUP_SUFFIX"
    else
        echo "An existing themes-list file was found at:"
        echo "    $THEMES_LIST_FILE"
        read -p "Do you want to back it up before replacing? (y/n): " answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            cp -v "$THEMES_LIST_FILE" "$THEMES_LIST_FILE$BACKUP_SUFFIX"
            msg "Backed up to $THEMES_LIST_FILE$BACKUP_SUFFIX"
        else
            warn "Skipping backup of themes-list."
        fi
    fi
fi

if [[ -f "$TEMP_DIR/jwm-config/themes-list" ]]; then
    cp -v "$TEMP_DIR/jwm-config/themes-list" "$JWM_CONFIG_DEST"
    msg "themes-list updated."
else
    warn "themes-list not found in repository."
fi

# --- Finish ---
msg "Artwork installation complete."
echo -e "\nPlease run 'jwm -restart' or log out and back in to see the new themes and wallpapers."
