{
  description = "Meine erste flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [];
        };
      in
      {
        nixosConfigurations.meinSystem = {
          inherit system;
          modules = [
            ./configuration.nix
            # Hier könnten weitere Module hinzugefügt werden, falls nötig.
          ];
        };
      }
    );
}
