{ config, pkgs, ... }:
let
  myAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-config/#default";
    hms = "home-manager switch --flake ~/nixos-config/#loki";
  };
in
{
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
