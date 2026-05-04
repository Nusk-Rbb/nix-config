# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal NixOS desktop flake. Single host (`nixos-personal`, `x86_64-linux`) and
single user (`nusk`). Stack: niri (compositor) + noctalia-shell (bar/shell) +
ghostty + zed/vim + vivaldi/chrome.

## Architecture

Two outputs in `flake.nix` share the same `inputs`:

- `nixosConfigurations.nixos-personal` — system, built from
  `system/configuration.nix` plus `inputs.niri.nixosModules.niri`.
- `homeConfigurations.nusk` — home-manager (standalone, **not** the NixOS
  module), built from the `./home` directory plus
  `inputs.niri.homeModules.niri` and `inputs.noctalia.homeModules.default`.

Because home-manager is standalone, **system rebuild and home rebuild are
independent steps** — changes to `home/` do not require `nixos-rebuild`.

`inputs` is forwarded to every module via `specialArgs` / `extraSpecialArgs`,
so any module can take `{ inputs, ... }` to reach flake inputs directly.

### Module split

- `system/configuration.nix` — NixOS-only concerns: boot, locale, networking,
  pipewire, fcitx5-mozc, xdg portals (gnome+gtk for niri), greetd+tuigreet,
  fonts, the `nusk` user, and `programs.niri.enable = true` (the option comes
  from `niri.nixosModules.niri`, which `disabledModules`'s the upstream
  nixpkgs niri module — do not import both).
- `system/hardware-configuration.nix` — machine-specific, must be regenerated
  per host with `nixos-generate-config`.
- `home/default.nix` — entrypoint. Sets `home.username`/`homeDirectory`/
  `stateVersion`, session env vars (Wayland, `XDG_CURRENT_DESKTOP=niri`,
  `EDITOR`/`BROWSER`/`TERMINAL`), common Wayland tools, and imports the rest.
- `home/programs.nix` — user-facing apps: vivaldi, google-chrome (via
  `home.packages`, since HM has no `programs.*` modules for them), vim
  (`defaultEditor`), zed-editor, ghostty.
- `home/niri.nix` — niri config via the niri-flake DSL. Keybinds use
  `with config.lib.niri.actions;` — that scope is provided by
  `niri.homeModules.niri` and is unavailable without it.
- `home/noctalia.nix` — `programs.noctalia-shell.enable = true;`. Noctalia is
  launched from niri's `spawn-at-startup`, not a systemd user service.

## Common commands

System rebuild (run from repo root):

```sh
sudo nixos-rebuild switch --flake .#nixos-personal
```

Home-manager rebuild:

```sh
home-manager switch --flake .#nusk
```

Lock / update inputs (no `flake.lock` is committed yet — first build will
generate it):

```sh
nix flake update                       # bump every input
nix flake lock --update-input niri     # bump one input
```

Validate without building:

```sh
nix flake check
nix flake show
```

Iterating on a single module — evaluate the option to surface eval errors fast:

```sh
nix eval .#nixosConfigurations.nixos-personal.config.programs.niri.enable
nix eval .#homeConfigurations.nusk.config.programs.ghostty.settings
```

## Conventions and gotchas

- Use 2-space indent, `{ ... }:` arg headers, trailing semicolons. Match the
  existing style in `home/niri.nix`.
- niri-flake replaces nixpkgs' niri module; do not also write
  `services.xserver.windowManager.niri` or import the upstream niri module.
- Adding a flake input requires three coordinated edits in `flake.nix`:
  `inputs.<name>`, the destructured argument list of `outputs`, and the
  module list of whichever output consumes it.
- New home-manager files must be added to the `imports` list in
  `home/default.nix` — there is no auto-discovery.
- `pkgs.vivaldi` and `pkgs.google-chrome` are unfree; `nixpkgs.config.allowUnfree`
  is set in both `system/configuration.nix` and `home/default.nix` and both
  must stay enabled.
- niri's cachix (`https://niri.cachix.org`) is intentionally **not**
  preconfigured — add it via `cachix use niri` if local builds are slow.
- The development branch for this work is `claude/nixos-desktop-setup-ZLv7v`
  (per repo policy); push there, not `main`.
