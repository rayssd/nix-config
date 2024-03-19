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

  outputs = { self, nixpkgs, home-manager, nix-darwin, nix-homebrew, ... }@inputs:
    let
      MacOSVersion = "ventura";
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;

      x86Linux = "x86_64-linux";
      x86pkgs = nixpkgs.legacyPackages.${x86Linux};

      args = {
        userAppsPath = "modules/user";
        systemAppsPath = "modules/system";
        macUser = "ray";
        linuxUser = "loki";
        terminal = "alacritty";
        editor = "neovim";
        shell = "zsh";
        browser = "firefox";
        multiplexer = "tmux";
        fuzzyFinder = "fzf";
      };

    in
    {
      nixosConfigurations = {
        "default" = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            inherit inputs;
            inherit args;
          };
          modules = [
            ./hosts/default/configuration.nix
            # this line below + another line configuration.nix
            # allows all configuration.nix to use home-manager modules
            # inputs.home-manager.nixosModules.default
          ];
        };
      };

      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = rec { 
            inherit inputs args; 
            nixcasks = import inputs.nixcasks {
              inherit pkgs nixpkgs;
              osVersion = MacOSVersion;
            };
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              config.packageOverrides = prev: {
                inherit nixcasks;
              };
              # nixcasks = inputs.nixcasks.legacyPackages."${x86Darwin}";
            };
          };
          modules = [
            ./hosts/darwin/configuration.nix

            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                # addd custom flake below, inherit <custom-flake>
                extraSpecialArgs = { inherit args; };
                users.${args.macUser}.imports = [ ./hosts/darwin/home.nix ];
              };
            }

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = args.macUser;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = inputs.homebrew-core;
                  "homebrew/homebrew-cask" = inputs.homebrew-cask;
                  "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = false;
              };
            }
          ];
        }
      );

      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."darwin".pkgs;

      homeConfigurations = {
        ${args.linuxUser} = home-manager.lib.homeManagerConfiguration {
          inherit x86pkgs;
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = { inherit args; };
          modules = [
            ./hosts/default/home.nix
          ];
        };
      };
    };
}
