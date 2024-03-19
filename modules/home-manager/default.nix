{ args, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # addd custom flake below, inherit <custom-flake>
    extraSpecialArgs = { inherit args; };
    users.${args.mac.user}.imports = [ ../../${args.hostsPath}/darwin/home.nix ];
  };
}

