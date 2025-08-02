#!/bin/bash

# Variables
REPO_URL="https://github.com/funos-linux/funos-artwork.git"
TEMP_DIR="/tmp/funos-artwork"
WALLPAPER_DEST="/opt/artwork/wallpaper"
JWM_THEME_DEST="$HOME/.config/jwm/themes"
JWM_CONFIG_DEST="$HOME/.config/jwm"

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

# --- Replace themes-list ---
echo "Installing themes-list to $JWM_CONFIG_DEST..."
mkdir -p "$JWM_CONFIG_DEST"
cp -v "$TEMP_DIR/jwm-config/themes-list" "$JWM_CONFIG_DEST"

echo "✅ Artwork installation complete."

echo -e "\n🔁 Please run 'jwm -restart' or log out and back in to see the new themes and wallpapers."