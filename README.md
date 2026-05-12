# NixOS desktop: niri + noctalia-shell

Minimal flake-based NixOS configuration with the following stack:

| Component        | Choice                                |
| ---------------- | ------------------------------------- |
| Compositor       | [niri](https://github.com/YaLTeR/niri) (scrollable tiling Wayland) |
| Shell / bar      | [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) |
| Terminal         | [Ghostty](https://ghostty.org)        |
| Editors          | Zed, Vim                              |
| Browsers         | Vivaldi, Google Chrome                |
| Display manager  | greetd + tuigreet                     |
| Audio            | PipeWire                              |
| Input method     | fcitx5 + mozc                         |

## Layout

```
flake.nix                  # inputs: nixpkgs, home-manager, niri-flake, noctalia
system/
  configuration.nix        # NixOS host (niri, greetd, pipewire, portals, fcitx5)
  hardware-configuration.nix
home/
  default.nix              # home-manager entrypoint, session vars, common pkgs
  programs.nix             # vivaldi, chrome, vim, zed, ghostty
  niri.nix                 # niri keybinds & layout
  noctalia.nix             # noctalia-shell
```

## Usage

Replace `system/hardware-configuration.nix` with the one generated for your
machine (`nixos-generate-config --root /mnt`), then:

```sh
sudo nixos-rebuild switch --flake .#nixos-personal
home-manager switch --flake .#nusk
```

## Default keybinds (niri)

| Bind                 | Action                          |
| -------------------- | ------------------------------- |
| `Mod+Return`         | ghostty                         |
| `Mod+B` / `Mod+Sh+B` | vivaldi / google-chrome         |
| `Mod+E`              | zed                             |
| `Mod+D`              | fuzzel launcher                 |
| `Mod+Q`              | close window                    |
| `Mod+H/J/K/L`        | focus column / window           |
| `Mod+Sh+H/J/K/L`     | move column / window            |
| `Mod+1..9`           | focus workspace                 |
| `Mod+Sh+1..9`        | send column to workspace        |
| `Mod+R`              | cycle preset column width       |
| `Mod+F` / `Mod+Sh+F` | maximize column / fullscreen    |
| `Print`              | area screenshot                 |
