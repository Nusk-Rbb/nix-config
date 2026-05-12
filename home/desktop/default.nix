{ pkgs, config, ... }:

{
  imports = [
    ./programs.nix
    ./niri.nix
    ./noctalia.nix
    ./ghostty.nix
    ./git.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.username = "nusk";
  home.homeDirectory = "/home/nusk";
  home.stateVersion = "25.11";

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
    bc
    eza
    xwayland-satellite
    kdePackages.dolphin
    claude-code
    discord
    vicinae
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "nemo.desktop";
      "application/x-gnome-saved-search" = "nemo.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "text/html" = "vivaldi-stable.desktop";
      "x-scheme-handler/about" = "vivaldi-stable.desktop";
      "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
      "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
    };
  };

  programs.home-manager.enable = true;
}
