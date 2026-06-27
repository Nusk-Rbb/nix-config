{ pkgs, ... }:

let
  mactahoeKvantum = pkgs.callPackage ../../pkgs/mactahoe-kvantum-theme.nix { };
in
{
  qt = {
    enable = true;
    platformTheme.name = "gtk2";
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    mactahoeKvantum
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];
}
