{ pkgs, ... }:

{
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

# XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };
}
