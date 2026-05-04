{ pkgs, ... }:

{
  imports = [
    ./programs.nix
    ./niri.nix
    ./noctalia.nix
  ];

  home.username = "nusk";
  home.homeDirectory = "/home/nusk";
  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    BROWSER = "vivaldi";
    EDITOR = "vim";
    TERMINAL = "ghostty";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    brightnessctl
    playerctl
    pavucontrol
    fuzzel
  ];

  programs.home-manager.enable = true;
}
