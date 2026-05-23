# Linux Gaming and Streaming Setup

Personal configs, scripts, and notes for a single-screen Linux gaming and streaming environment. Originally built on Fedora + NVIDIA + OBS, currently running on Debian + KDE Plasma. The tools (GameMode, MangoHud, Proton, Chromium app-windows) are distro-agnostic and the configs in this repo work on both.

## Story and motivation

Linux gaming is not as plug-and-play as Windows. Drivers, OBS builds, Proton versions, and overlay tooling all need tuning. The payoff is worth it: better customization, lighter resource use on the same hardware, and full control over the setup.

This repo documents the path I took to get there:

- Fixing OBS crashes by switching from the RPM build to the Flatpak build
- Keeping NVIDIA proprietary drivers current on Fedora via `akmods`
- Using GameMode for CPU governor and scheduler tweaks while gaming
- Enabling MangoHud overlays for FPS, frametimes, CPU/GPU temps, RAM, VRAM, and I/O
- Writing small launch scripts that keep Steam launch options clean (`gamemoderun mangohud %command%`) and put Twitch chat on the same screen as the game without a second monitor

It is both a reference for me and a starting point for anyone wanting a stable Linux gaming and streaming rig.

## The stack

- OS: Debian 13 + KDE Plasma (primary), Fedora notes kept for reference
- Game runtime: Steam + Proton
- Overlay: MangoHud
- Performance: GameMode
- Streaming: OBS Studio (Flatpak build recommended)
- Chat: Chromium app-window pinned with KDE "Keep Above Others"

## Quick setup

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install mangohud gamemode chromium
# Steam: install from steam.com or via flatpak
```

### Fedora

```bash
sudo dnf install mangohud gamemode chromium
# OBS: prefer the Flatpak build to avoid RPM/library mismatches
flatpak install flathub com.obsproject.Studio
```

### Steam launch options

Drop the MangoHud config into `~/.config/MangoHud/MangoHud.conf` (see `MangoHud.conf` in this repo). Then per-game launch options reduce to:

```
mangohud %command%
```

Or with GameMode:

```
gamemoderun mangohud %command%
```

### Twitch chat on the same screen

Run `twitch-chat.sh` to open the Twitch popout chat as a standalone Chromium app window, then right-click the window in KDE Plasma: **More Actions -> Keep Above Others**. Run the game in **Borderless Windowed** so the chat stays visible without fullscreen fighting back.

## Repo contents

| File | Purpose |
| --- | --- |
| `MangoHud.conf` | Drop-in MangoHud config: GPU/CPU/RAM/VRAM/I/O telemetry, top-right placement, rounded corners |
| `twitch-chat.sh` | Launches the Twitch popout chat as a standalone Chromium app window |

## Notes and gotchas

- **OBS on Fedora**: the RPM build has historically been fragile around Wayland and PipeWire screen capture. The Flatpak build is more stable.
- **NVIDIA on Fedora**: use RPM Fusion + `akmods` so the kernel module rebuilds automatically on kernel updates. Otherwise you end up with a black screen after a routine `dnf upgrade`.
- **Fullscreen vs Borderless Windowed**: exclusive fullscreen will steal focus from the chat overlay every few seconds. Always Borderless Windowed for this setup.
- **MangoHud config location**: `~/.config/MangoHud/MangoHud.conf` is read globally. Per-game configs can live next to the game in `MangoHud.<game>.conf`.

## License

MIT. Use, fork, adapt.
