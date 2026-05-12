{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vivaldi
    google-chrome
    claude-code
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zed-editor.enable = true;
}
