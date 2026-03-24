let configDir = ../config;
in
{
  home.file = {
    # Direcotry
    ".config/alacritty".source = "${configDir}/alacritty";
    ".config/fastfetch".source = "${configDir}/fastfetch";
    ".config/fuzzel".source = "${configDir}/fuzzel";
    ".config/hypr".source = "${configDir}/hypr";
    ".config/kde-material-you-colors".source = "${configDir}/kde-material-you-colors";
    ".config/Kvantum".source = "${configDir}/Kvantum";
    ".config/matugen".source = "${configDir}/matugen";
    ".config/mpv".source = "${configDir}/mpv";
    ".config/wlogout".source = "${configDir}/wlogout";
    ".config/xdg-desktop-portal".source = "${configDir}/xdg-desktop-portal";

    # Files
    ".config/chrome-flags.conf".source = "${configDir}/chrome-flags.conf";
    ".config/code-flags.conf".source = "${configDir}/code-flags.conf";
    ".config/darklyrc".source = "${configDir}/darklyrc";
    ".config/dolphinrc".source = "${configDir}/dolphinrc";
    ".config/kdeglobals".source = "${configDir}/kdeglobals";
    ".config/thorium-flags.conf".source = "${configDir}/thorium-flags.conf";
  };
}
