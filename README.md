# 🛠️ Dotfiles & Linux Setup

> **Personalized, minimal, and visually consistent Linux environment — with full Dark & Light mode support.**

---

## ✨ Overview

This repository contains my curated dotfiles and user-level configurations.
All settings are managed by [yadm](https://yadm.io/), allowing simple deployment and synchronization across devices.

<div align="center">

| ⚡ Fast setup | 🎨 Beautiful themes | 🌓 Dark & Light modes |
|:-----------:|:------------------:|:---------------------:|

</div>

---

## 🎯 Key Features

- **🔗 Centralized Neovim Config**  
  Deploy a modern Neovim setup instantly (config is external but easily bootstrapped).

- **🎛️ Sway Window Manager**  
  Custom tiling window manager with seamless dark/light theming.

- **🚀 Wofi Launcher**  
  Application launcher with personalized menus and both dark & light themes.

- **🖥️ Foot Terminal**  
  Terminal emulator setup for both dark and light environments.

- **⚙️ Bootstrap Script**  
  Automated script to initialize Neovim and essential configs in a single step.

---

## 🌓 Dark & Light Modes

All major desktop components feature both dark and light themes so you can easily switch based on mood or lighting:

- **🌗 Wofi** (application launcher)
- **🖥️ Foot** (terminal emulator)
- **🪟 Sway** (window manager)

> _Enjoy a consistent, beautiful interface in any environment._

---

## 🚀 Quick Start

```sh
# Clone with yadm
mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x ~/.local/bin/yadm
~/.local/bin/yadm clone https://github.com/alexandermiss/dotfiles.git
~/.local/bin/yadm restore --staged $HOME
~/.local/bin/yadm checkout -- $HOME

# Initialize Neovim and configs
~/.local/bin/yadm bootstrap

# Optionally remove yadm after setup
rm -rf ~/.local/bin/yadm
```

---

## 📂 Structure

```text
.config/
├── sway/      # Sway configs (dark & light)
├── wofi/      # Wofi configs & themes
├── foot/      # Foot terminal configs (dark & light)
├── nvim/      # Neovim config (external repo)
├── yadm/      # yadm config & bootstrap
└── ...
```

---

## 🙋‍♂️ Maintainer

**[alexandermiss](https://github.com/alexandermiss)**

---

> _Enjoy a beautiful, productive desktop — tailored for both dark and light modes!_

