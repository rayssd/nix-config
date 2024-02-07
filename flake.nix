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
      profilePath = "profiles/default";
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./${profilePath}/configuration.nix
            # this line below allows all configuration.nix to use home-manager modules
            # inputs.home-manager.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        loki = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./${profilePath}/home.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
    };
}
