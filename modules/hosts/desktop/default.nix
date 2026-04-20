{ inputs, ... }:

let
  hardwareModule = import ./hardware.nix;
  configurationModule = import ./configuration.nix;
in
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      hardwareModule
      configurationModule
    ];
  };
}
