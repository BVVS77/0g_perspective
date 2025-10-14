````markdown
# 0g_perspective
Immersive Camera Perspective System for FiveM by ZeroGravity

## ✨ Features
- 🎥 Switch freely between:
  - First Person (FPP)
  - Third Person (close)
  - Third Person (far)
- 🔄 Smooth toggle via key or commands:
  - `/firstperson`
  - `/thirdperson`
  - `/thirdperson2`
- 🔒 Server-side **forced perspective** (admins can lock view)
- 💾 Automatic **save & load** of last used camera view
- 🌍 Multi-framework support:
  - ESX, QBCore, ox_lib
  - fallback → chat notifications
- 🌐 Locales included: `en`, `pl`
- ⚡ Optimized and lightweight

## 📦 Installation
1. Download or clone this repository:
   ```bash
   git clone https://github.com/ZeroGravityDev/0g_perspective.git
````

2. Place inside your `resources/[scripts]` folder.
3. Add to your `server.cfg`:

   ```cfg
   ensure 0g_perspective
   ```

## ⚙️ Configuration

Edit `config.lua` to adjust:

* `DefaultView` → starting camera view (0, 2, 4)
* `AllowedViews` → enable/disable specific views
* `ToggleKey` → keyboard shortcut (default: `V`)
* `Framework` → auto, esx, qb, ox, or none

## 🖥️ Commands

* `/firstperson` → switch to FPP
* `/thirdperson` → switch to TPP (near)
* `/thirdperson2` → switch to TPP (far)

Admins (server events):

* `zerogravity:forceView [mode]` → force camera (0/2/4)
* `zerogravity:forceView off` → disable force

## 🖼️ Preview

(Add screenshots or gifs in `/media` folder)

## 📚 Support

🌐 [ZeroGravity Tebex](https://zerogravity.tebex.io)
💬 [Discord](https://discord.gg/YbuNXpwkWY)

## 📜 License

MIT License – feel free to use and modify.

```

0g_perspective – immersive camera perspective system for FiveM.
Switch between first-person and third-person views, with server-side forced mode, saved preferences, multi-framework support (ESX/QB/ox), and localization.
Optimized, lightweight, and easy to configure.

```
