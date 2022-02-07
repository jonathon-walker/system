{
  description = "Nix configurations";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs.lib) attrValues singleton;
    in {
      darwinConfigurations = rec {
        macbook-intel = darwinSystem {
          system = "x86_64-darwin";
          modules = attrValues self.darwinModules ++ [
            ./darwin
            home-manager.darwinModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathon = import ./home.nix;
            }
          ];
        };
      };

      darwinModules = {
        security-pam = import ./modules/darwin/security/pam.nix;
      };
    };
}
