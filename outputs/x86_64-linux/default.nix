{
  nixpkgs,
  home-manager,
  inputs,
  overlays,
  sops-nix,
  nixos-generators,
  ...
}:

nixpkgs.lib.foldl' nixpkgs.lib.recursiveUpdate { } [
  (import ./systems/home-aspen.nix {
    inherit
      inputs
      nixpkgs
      home-manager
      overlays
      nixos-generators
      ;
  })
  (import ./systems/home-birch.nix {
    inherit
      inputs
      nixpkgs
      home-manager
      overlays
      ;
  })
  (import ./systems/home-oak.nix {
    inherit
      inputs
      nixpkgs
      home-manager
      overlays
      ;
  })
]
