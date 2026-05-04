{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vivaldi
    google-chrome
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zed-editor.enable = true;

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      window-decoration = false;
    };
  };
}
