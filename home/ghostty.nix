{ ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      window-decoration = true;
      cursor-style = "block";
      background-opacity = 0.55;
      background-blur = true;
      shell-integration-features = "no-cursor";
    };
  };
}
