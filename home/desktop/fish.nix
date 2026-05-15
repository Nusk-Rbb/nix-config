{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      nv = "nvim";
      ip = "ip -c";
      cls = "clear";
    };
    plugins = [
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
    ];
  };

  home = {
    file = {
      fish_prompt = {
        source = ../../config/fish/fish_prompt.fish;
        target = ".config/fish/functions/fish_prompt.fish";
      };
      fish_right_prompt = {
        source = ../../config/fish/fish_right_prompt.fish;
        target = ".config/fish/functions/fish_right_prompt.fish";
      };
      scheme = {
        source = ../../config/fish/scheme.fish;
        target = ".config/fish/functions/scheme.fish";
      };
    };
  };
}
