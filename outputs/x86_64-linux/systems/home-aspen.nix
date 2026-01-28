{
  nixpkgs,
  home-manager,
  inputs,
  overlays,
  ...
}:
{
  nixosConfigurations.aspen = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ../../../hosts/home-aspen
      ../../../modules/linux/base
      ../../../config
      ../../../generators/docker.nix
      (
        { ... }:
        {
          nixpkgs.overlays = overlays;
        }
      )
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Backup conflicting files when switching to not cause errors
        home-manager.backupFileExtension = "backup";
        home-manager.users.nusk.imports = [
          ../../../home/base/home.nix
          ../../../home/base/core
          ../../../home/base/tui
          ../../../home/linux/sops.nix
          ../../../home/linux/yubikey.nix
        ];
      }
    ];
  };
}
