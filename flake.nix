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


  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
    let
      x86system = "x86_64-linux";
      x86pkgs = nixpkgs.legacyPackages.${x86system};
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
        "intelMac" = nix-darwin.lib.darwinSystem {
          # system = "x86_64-darwin";
          # pkgs =
          specialArgs = { inherit inputs; };
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
