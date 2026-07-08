# void-repo

Personal [Void Linux](https://voidlinux.org) package repository, served from
GitHub Pages. Currently ships [honey](https://github.com/l3mah/honey-wm), a
tiling Wayland compositor.

x86_64 glibc only for now.

## Use

```sh
echo 'repository=https://l3mah.github.io/void-repo/x86_64' | sudo tee /etc/xbps.d/20-l3mah.conf
sudo xbps-install -S honey
```

The first install asks you to accept this repository's signing key. The
fingerprint should be:

```
86:d4:ee:1f:be:7d:f6:e2:83:8e:8f:cd:14:ee:be:4c
```

Updates then arrive through the normal `xbps-install -Su`.

## Packages

| Package | Description |
|---|---|
| `honey` | Tiling Wayland compositor on wlroots (master-stack, dynamic config) |
| `honey-waybar` | Waybar modules for the honey compositor |

## How it is built

Each package is compiled with `xbps-src` from the template kept in the
upstream repo ([honey-wm/contrib/void](https://github.com/l3mah/honey-wm/tree/main/contrib/void)),
then copied, indexed, and signed here by [release.sh](release.sh).
