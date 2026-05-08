{ pkgs, ... }:

let
  mactahoe = pkgs.callPackage ../pkgs/mactahoe-gtk-theme.nix { };
  themeName = "MacTahoe-Dark";
in
{
  home.packages = [ mactahoe ];

  gtk = {
    enable = true;
    theme = {
      name = themeName;
      package = mactahoe;
    };
  };

  # GTK4 / libadwaita apps look at ~/.config/gtk-4.0 directly,
  # not at $XDG_DATA_DIRS/themes — so symlink the assets in.
  xdg.configFile = {
    "gtk-4.0/gtk.css".source =
      "${mactahoe}/share/themes/${themeName}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source =
      "${mactahoe}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
    "gtk-4.0/assets".source =
      "${mactahoe}/share/themes/${themeName}/gtk-4.0/assets";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = themeName;
    };
  };
}
