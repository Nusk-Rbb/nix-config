{ pkgs, ... }:

let
  mactahoeKvantum = pkgs.callPackage ../../pkgs/mactahoe-kvantum-theme.nix { };
in
{
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum-dark";
  };

  home.packages = with pkgs; [
    mactahoeKvantum
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=MacTahoeDark
  '';
}
