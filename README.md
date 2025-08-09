# funos-artwork

This repository contains additional artwork files for FunOS, including:

* 15 new wallpapers
* 10 new JWM themes
* `themes-list` file for dynamic JWM theme menus

These files are included by default in **FunOS 24.04.3**.
Users of **FunOS 22.04.5**, **FunOS 24.04.2** and **FunOS 25.04** can manually add these wallpapers and themes using the provided install script.

## Contents

```
funos-artwork/
├── wallpapers/       # 15 new wallpapers
├── jwm-themes/       # 10 new JWM themes
└── jwm-config/       # new themes-list file
```

## Installation

To install the wallpapers and themes on FunOS 22.04.5, 24.04.2 or 25.04, run:

```bash
sudo apt update
sudo apt install git
wget https://raw.githubusercontent.com/funos-linux/funos-artwork/main/install-funos-artwork.sh
bash install-funos-artwork.sh --non-interactive
```

This will:

* Copy wallpapers to `/opt/artwork/wallpaper/`
* Copy JWM themes to `~/.config/jwm/themes/`
* Overwrite `~/.config/jwm/themes-list` with the latest version

## Note

After installing, you may need to **reload the JWM menu** for the new themes to appear:

```bash
Menu → Reload menu
```
