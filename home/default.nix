{ config, pkgs, pkgs-unstable, lib, inputs, ... }:

{
  imports = [
    ./user
  ];

  home.username = "nusk";
  home.homeDirectory = "/home/nusk";
  home.stateVersion = "25.11";
}
