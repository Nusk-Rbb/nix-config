{
    description = "My NixOS Flakes";

    inputs = {
	    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
      nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, illogical-flake, ... }@inputs:
	let
	    lib = nixpkgs.lib;
	    system = "x86_64-linux";
	    pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
	in
    {
		nixosConfigurations.nixos-personal = lib.nixosSystem {
                inherit system;
				modules = [
                    ./system/configuration.nix
				];
                specialArgs = {
                    inherit pkgs-unstable;
                };
        };

		homeConfigurations = {
			nusk = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home ];
                extraSpecialArgs = {
                    inherit pkgs-unstable;
                    inherit inputs;
                };
			};
		};
    };
}
