# funos-artwork

This repository contains additional artwork files for FunOS, including:

* 15 new wallpapers
* 10 new JWM themes
* `themes-list` file for dynamic JWM theme menus

These files are included by default in **FunOS 24.04.3**.
Users of **FunOS 24.04.2** and **FunOS 25.04** can manually add these wallpapers and themes using the provided install script.

## 📦 Contents

```
funos-artwork/
├── wallpapers/       # 15 new wallpapers
├── jwm-themes/       # 10 new JWM themes
└── jwm-config        # JWM configuration file
```

## 🚀 Installation

To install the wallpapers and themes on FunOS 24.04.2 or 25.04, run:

```bash
wget https://raw.githubusercontent.com/funos-linux/funos-artwork/main/install-funos-artwork.sh
bash install-funos-artwork.sh
```

This will:

* Copy wallpapers to `/opt/artwork/wallpaper/`
* Copy JWM themes to `~/.config/jwm/themes/`
* Overwrite `~/.config/jwm/themes-list` with the latest version

## 💡 Note

After installing, you may need to **reload the JWM menu** for the new themes to appear:

```bash
Menu → Settings → Reload Menu
```

## 📜 License

All wallpapers are sourced from Adobe Stock under a valid license for distribution with FunOS.
JWM themes are released under the [MIT License](LICENSE).

---

Let me know if you want a **localized (Bahasa Indonesia)** version or if you're planning to support more versions of FunOS.
