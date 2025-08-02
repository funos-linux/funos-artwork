#!/bin/bash

# Variables
REPO_URL="https://github.com/funos-linux/funos-artwork.git"
TEMP_DIR="/tmp/funos-artwork"
WALLPAPER_DEST="/opt/artwork/wallpaper"
JWM_THEME_DEST="$HOME/.config/jwm/themes"
JWM_CONFIG_DEST="$HOME/.config/jwm"
THEMES_LIST_FILE="$JWM_CONFIG_DEST/themes-list"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d%H%M%S)"

echo "Downloading FunOS artwork files..."

# Clean up old temp directory if exists
rm -rf "$TEMP_DIR"
git clone "$REPO_URL" "$TEMP_DIR"

if [[ $? -ne 0 ]]; then
    echo "❌ Failed to clone repository. Check your internet connection."
    exit 1
fi

echo "✅ Repository downloaded to $TEMP_DIR"

# --- Install Wallpapers ---
echo "Installing wallpapers to $WALLPAPER_DEST..."
sudo mkdir -p "$WALLPAPER_DEST"
sudo cp -v "$TEMP_DIR/wallpapers/"* "$WALLPAPER_DEST"

# --- Install JWM Themes ---
echo "Installing JWM themes to $JWM_THEME_DEST..."
mkdir -p "$JWM_THEME_DEST"
cp -rv "$TEMP_DIR/jwm-themes/"* "$JWM_THEME_DEST"

# --- Backup and Replace themes-list ---
echo "Installing themes-list to $JWM_CONFIG_DEST..."
mkdir -p "$JWM_CONFIG_DEST"

if [[ -f "$THEMES_LIST_FILE" ]]; then
    echo "⚠️  An existing themes-list file was found at:"
    echo "    $THEMES_LIST_FILE"
    read -p "Do you want to back it up before replacing? (y/n): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        cp -v "$THEMES_LIST_FILE" "$THEMES_LIST_FILE$BACKUP_SUFFIX"
        echo "🗂️  Backed up to $THEMES_LIST_FILE$BACKUP_SUFFIX"
    else
        echo "❗ Skipping backup of themes-list."
    fi
fi

cp -v "$TEMP_DIR/jwm-config/themes-list" "$JWM_CONFIG_DEST"

echo "✅ Artwork installation complete."

echo -e "\n🔁 Please run 'jwm -restart' or log out and back in to see the new themes and wallpapers."
