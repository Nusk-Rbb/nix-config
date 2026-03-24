{
    imports = [
        ./git.nix
        ./gtk.nix
        ./shell.nix
        ./config.nix
        ./packages.nix
        ./programs.nix
        ./environment.nix
        ./hyprland.nix
        ./quickshell.nix
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
