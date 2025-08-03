# Dotfiles Configuration

This repository contains my personal dotfiles and system setup for a seamless Linux experience. It is managed with [yadm](https://yadm.io/) for easy deployment and synchronization across devices.

## Features

- **Neovim Configuration**: Quickly set up a modern Neovim environment using an external, maintained repository.
- **Sway Window Manager**: Customized configuration for both dark and light modes, offering a flexible and visually appealing tiling window management experience.
- **Wofi Launcher**: Personalized wofi menus with themes for dark and light modes, ensuring optimal readability and aesthetics.
- **Foot Terminal**: Terminal emulator configuration tailored for both dark and light schemes, enhancing your command-line experience in any lighting condition.
- **Bootstrap Script**: Automated setup script to initialize Neovim and essential configurations with a single command.

## Dark & Light Modes

All major desktop components support both dark and light themes. Easily switch between modes for:

- **Wofi** (application launcher)
- **Foot** (terminal emulator)
- **Sway** (window manager)

This ensures a consistent look, whether you prefer a light or dark working environment.

## Quick Start

```sh
# Clone your yadm-managed dotfiles
git clone <this-repo-url> ~/.config/yadm
cd ~/.config/yadm

# Run bootstrap to initialize Neovim config
./bootstrap
```

## Structure

```
.config/
├── sway/      # Sway window manager configs (dark & light)
├── wofi/      # Wofi launcher configs & themes
├── foot/      # Foot terminal configs (dark & light)
├── nvim/      # Neovim config (external repo, see bootstrap)
├── yadm/      # yadm config, including bootstrap script
└── ...
```

---

> **Maintained by [alexandermiss](https://github.com/alexandermiss)**

Enjoy a beautiful and productive desktop, tailored for dark and light themes!

