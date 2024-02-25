{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      host = "hosts/default";
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ 
            ./${host}/configuration.nix
            # this line below + another line configuration.nix
            # allows all configuration.nix to use home-manager modules
            # inputs.home-manager.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        loki = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = {};
          modules = [ 
            ./${host}/home.nix
          ];
        };
      };
    };
}
