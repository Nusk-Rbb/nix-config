{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.lanzaboote = {
  #   enable = true;
  #   pkiBundle = "/var/lib/sbctl";
  # };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  programs.niri.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.niri = {
      default = [ "gnome" "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.nusk = {
    isNormalUser = true;
    description = "nusk";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  # For Games
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # WiVRnサーバー
  services.wivrn = {
    enable = true;
    openFirewall = true;          # 必要なポートを自動で開ける
    # SteamVR用ゲームをWiVRn(OpenXR)で動かすための互換レイヤ
    monadoEnvironment = {
      XRT_COMPOSITOR_LOG = "debug";
      XRT_PRINT_OPTIONS = "on";
      IPC_EXIT_ON_DISCONNECT = "off";
    };

    # autoStart = true で起動時から動かせるが、手動起動の方が安定
    autoStart = false;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    sbctl
    lon
    (sddm-astronaut.override { embeddedTheme = "pixel_sakura"; })
  ];

  system.stateVersion = "25.11";
}
