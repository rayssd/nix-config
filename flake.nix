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
      
      args = {
        userAppsPath = "modules/user";
        systemAppPath = "modules/system";
        terminal = "alacritty";
        editor = "neovim";
        shell = "zsh";
        wm = "hyprland";
        browser = "firefox";
        keyremap = "keyd";
      };
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit args;
          };
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
          extraSpecialArgs = {
            inherit args;
          };
          modules = [ 
            ./${profilePath}/home.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
    };
}
