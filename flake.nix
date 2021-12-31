{
  description = "fuse-idmap";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      supportedSystems = [
        #"aarch64-darwin"
        "aarch64-linux"
        #"x86_64-darwin"
        "x86_64-linux"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        rev = if (self ? rev) then self.rev else "dirty";
      in
      rec {
        packages.fuse-idmap = pkgs.callPackage ./default.nix { inherit rev; };
        defaultPackage = packages.fuse-idmap;
      });
}
