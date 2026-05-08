# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal NixOS flake. Two hosts (`laptop` and `desktop`, both `x86_64-linux`),
single user (`nusk`). Stack: niri (compositor) + noctalia-shell (bar/shell) +
ghostty + zed/vim + vivaldi/chrome.

> `desktop` is the planned second host — its directory may not exist yet. When
> adding it, mirror `system/laptop/` and add a matching `nixosConfigurations`
> entry. Keep host-specific knobs (kernel, GPU, display, hostname,
> `hardware-configuration.nix`) inside the host directory, and lift anything
> shared by both hosts to a common module rather than duplicating.

## Architecture

`flake.nix` exposes one `nixosConfigurations.<host>` output per machine:

- `nixosConfigurations.laptop` / `nixosConfigurations.desktop` — system, built
  from `system/<host>/configuration.nix` plus `inputs.niri.nixosModules.niri`
  and `home-manager.nixosModules.home-manager`. Home-manager is integrated as
  a NixOS module (`home-manager.users.nusk`), with `useGlobalPkgs = true` and
  `useUserPackages = true`. The user's HM config imports `./home`,
  `inputs.niri.homeModules.niri`, and `inputs.noctalia.homeModules.default`.

Because home-manager runs as a NixOS module, **`nixos-rebuild switch` applies
both system and home changes** — there is no separate `home-manager switch`.

`inputs` is forwarded to every module via `specialArgs` /
`home-manager.extraSpecialArgs`, so any module can take `{ inputs, ... }` to
reach flake inputs directly.

### Module split

- `system/<host>/configuration.nix` — per-host NixOS config: boot, locale,
  networking, pipewire, fcitx5-mozc, xdg portals (gnome+gtk for niri), display
  manager, fonts, the `nusk` user, and `programs.niri.enable = true` (the
  option comes from `niri.nixosModules.niri`, which `disabledModules`'s the
  upstream nixpkgs niri module — do not import both). Currently only
  `system/laptop/` exists; `system/desktop/` is planned.
- `system/<host>/hardware-configuration.nix` — machine-specific, regenerated
  per host with `nixos-generate-config --root <dir>` and committed.
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

System + home rebuild (run from repo root — applies both). Pick the host
matching the machine you're on:

```sh
sudo nixos-rebuild switch --flake .#laptop      # on the laptop
sudo nixos-rebuild switch --flake .#desktop     # on the desktop (when added)
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

Iterating on a single module — evaluate the option to surface eval errors fast
(swap `laptop` for `desktop` as needed):

```sh
nix eval .#nixosConfigurations.laptop.config.programs.niri.enable
nix eval .#nixosConfigurations.laptop.config.home-manager.users.nusk.programs.ghostty.settings
```

## Pinning a `fetchFromGitHub` source

When writing a custom derivation under `pkgs/`, pin both `rev` and `hash`.

Get `rev` — always a full commit SHA, never a branch name (a branch would
re-fetch on every eval and break reproducibility):

```sh
git ls-remote https://github.com/OWNER/REPO.git HEAD          # default branch tip
git ls-remote https://github.com/OWNER/REPO.git v1.2.3        # tag
gh api repos/OWNER/REPO/commits/main --jq .sha                # via gh CLI
```

Get `hash` — let Nix compute it. Set `hash = lib.fakeHash;`, build, then copy
the `got: sha256-...=` line from the error back into the file:

```sh
nix build --impure --expr '(import <nixpkgs> {}).callPackage ./pkgs/foo.nix {}' --no-link
# error: hash mismatch in fixed-output derivation ...
#          specified: sha256-AAAAAAAA...
#             got:    sha256-xS/RAPAREzteA6BRL3ZGrKk8Uml6/AjZRGQGQCOCrek=
```

Use the SRI form (`sha256-<base64>=`) — that's what nixpkgs prefers and what
`fetchFromGitHub` returns in its error message.

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
  must be set in each `system/<host>/configuration.nix` and applies to HM via
  `home-manager.useGlobalPkgs = true`. Do **not** set `nixpkgs.config.*` inside
  `home/` — it errors under `useGlobalPkgs`.
- niri's cachix (`https://niri.cachix.org`) is intentionally **not**
  preconfigured — add it via `cachix use niri` if local builds are slow.
- The development branch for this work is `claude/nixos-desktop-setup-ZLv7v`
  (per repo policy); push there, not `main`.
