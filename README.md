<p align="center">
  <img src="./assets/banner.png" alt="Impulse" width="100%">
</p>

<p align="center">
  <strong>Games on your Mac, without the usual VM baggage.</strong>
</p>

<p align="center">
  <img src="./assets/icon.png" alt="" width="48" height="48">
</p>

---

**Impulse** is a virtual machine for Apple Silicon Macs built for real workloads — gaming, development, creative tools, and general desktop use. You get a full Linux desktop inside a window, with graphics that actually use your Mac’s GPU — not a sluggish software renderer hiding behind layers of emulation.

It’s lighter than a typical VM setup because it was designed around performance from the start. We ship **KDE Plasma** as the desktop environment — a full, modern Linux desktop that handles games, dev workflows, and day-to-day apps without feeling like a stripped-down sandbox.

## What you need

- A Mac with Apple Silicon (M1 or newer)
- macOS 26 or later

## Getting started

**1.** Download the latest build from [**Releases**](https://github.com/Zonharo/impulse/releases), or build the app yourself (see [Building](#building)).

**2.** Grab a config file from [`examples/gaming.impulse`](examples/gaming.impulse), or create one with:

```bash
cat > "$HOME/gaming.impulse" <<'EOF'
format_version = 1

memory_mib = 16384
vcpus = 8

disk = "gaming.raw"
disk_size_gib = 24
EOF
```

The virtual disk appears next to the config file. To make it bigger later, stop the VM, bump `disk_size_gib`, and launch again. You can’t shrink it.

**3.** Open Impulse and pick your `.impulse` file.

If macOS blocks the app on first launch (it isn’t signed or notarized), go to **System Settings → Privacy & Security → Open Anyway**.

**4.** Wait for Linux to boot, set up a user, and log in. Booting takes about **30–45 seconds** — that’s normal. The first run takes a bit longer while Impulse finishes setting things up in the background.

**5.** Open **Applications → Games → Steam**, sign in, install something, and play — or use the desktop for whatever you need.

## What Impulse gives you

| | |
| :--- | :--- |
| **Graphics** | Hardware-accelerated Vulkan and OpenGL |
| **Games** | Windows titles via Proton, Linux-native builds, x86 games via FEX |
| **Desktop** | KDE Plasma on Wayland — familiar, modern, works with Steam |
| **Day-to-day** | Sound, networking, shared clipboard, Retina and high-refresh displays |

DirectX 9–11 games tend to work best today. Newer APIs are still catching up.

Performance demos and a full configuration guide are coming soon.

## Building

You’ll need macOS 26+, Xcode, Rust, and Docker.

```sh
brew install cmake meson ninja pkg-config python
make app
```

Output: `dist/Impulse.app`. Guest image artifacts land in `build/guest/`.

To launch straight from the build tree:

```sh
make run
```

That uses `examples/gaming.impulse` by default.

## Config files

VMs are described by `.impulse` files (plain TOML). The essentials:

- `memory_mib` — RAM
- `vcpus` — CPU cores
- `disk` — path to the disk image
- `disk_size_gib` — how big the virtual disk should be

See [`examples/gaming.impulse`](examples/gaming.impulse) for a working template.

## Thanks

Impulse’s graphics stack builds on forks maintained by the [UTM](https://mac.getutm.app/) project. Big credit to everyone who made that possible.
