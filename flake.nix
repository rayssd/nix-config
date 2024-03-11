{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcasks = {
      url = "github:jacekszymanski/nixcasks";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };


  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
    let
      x86Linux = "x86_64-linux";
      x86pkgs = nixpkgs.legacyPackages.${x86Linux};
      x86Darwin = "x86_64-darwin";
      ARMDarwin = "aarch64-darwin";
      MacOSVersion = "ventura";
    in
    {
      nixosConfigurations = {
        "default" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/default/configuration.nix
            # this line below + another line configuration.nix
            # allows all configuration.nix to use home-manager modules
            # inputs.home-manager.nixosModules.default
          ];
        };
      };

      darwinConfigurations = {
        system = x86Darwin;
        "intelMac" = nix-darwin.lib.darwinSystem {
          specialArgs = rec { 
            inherit inputs; 
            nixcasks = import inputs.nixcasks {
              inherit pkgs nixpkgs;
              osVersion = MacOSVersion;
            };
            pkgs = import nixpkgs {
              system = x86Darwin;
              config.allowUnfree = true;
              config.packageOverrides = prev: {
                inherit nixcasks;
              };
              # nixcasks = inputs.nixcasks.legacyPackages."${x86Darwin}";
            };
          };
          modules = [
            ./hosts/intelMac/configuration.nix

            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                # addd custom flake below, inherit <custom-flake>
                extraSpecialArgs = { };
                users."ray".imports = [ ./hosts/intelMac/home.nix ];
              };
            }

            inputs.nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = "ray";
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = inputs.homebrew-core;
                  "homebrew/homebrew-cask" = inputs.homebrew-cask;
                  "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
          ];
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."intelMac".pkgs;

      homeConfigurations = {
        "loki" = home-manager.lib.homeManagerConfiguration {
          inherit x86pkgs;
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = {};
          modules = [
            ./hosts/default/home.nix
          ];
        };
      };
    };
}
