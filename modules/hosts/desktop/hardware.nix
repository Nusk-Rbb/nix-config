{ self, inputs, ... }:

{
  flake.nixosModules.desktopHardware = { config, lib, pkgs, modulePath, ... }: {
    imports = [
      (modulePath + "/installer/scan/not-detected.nix")
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/525f32c9-8ed7-4bf3-81e9-2aa91299262a";
      fsType = "ext4";
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
