{ self, inputs, ... }:

{
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.desktopHardware
    ];

   nix.settings.experimental-features = [ "nix-commnad" "flakes" ];

   environment.systemPackages = with pkgs; [
     vivaldi
     ghostty
     vim
     zed-editor
   ]
  };
}
