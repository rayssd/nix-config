{ config, lib, pkgs, ... }:

{
  imports = [ ../tridactyl-native ];
  programs.firefox = {
    enable = true;
    # package = lib.optional (builtins.elem pkgs.system ["x86_64-darwin" "aarch64-darwin"]) (pkgs.nixcasks.firefox or {});
    package = if (builtins.elem pkgs.system ["x86_64-darwin" "aarch64-darwin"]) then pkgs.nixcasks.firefox else pkgs.firefox; 
    profiles.default = {
      userChrome = builtins.readFile ./userChrome.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
  home.file."./.config/tridactyl/tridactylrc".source = ./tridactylrc;
}


