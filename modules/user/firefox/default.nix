{ config, lib, pkgs,... }:

{
  #########################################################################
  # To fix Firefox hanging at first starup on a new installation
  # 1. Start firefox with a clean profile. ie: no profiles definition below
  # 2. Delete profiles.ini
  # 3. Rebuild nix config with profiles setting enabled
  # 4. Modify installs.ini to point to the default profile
  # 5. Restart firefox
  #########################################################################
  imports = [ ../tridactyl-native ];
  programs.firefox = {
    enable = true;
    # package = lib.optional (builtins.elem pkgs.system ["x86_64-darwin" "aarch64-darwin"]) (pkgs.nixcasks.firefox or {});
    package = if (builtins.elem pkgs.system ["x86_64-darwin" "aarch64-darwin"]) then pkgs.nixcasks.firefox else pkgs.firefox; 
    profiles = {
      default = {
        id = 0;
        isDefault = true;
        userChrome = builtins.readFile ./userChrome.css;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
        };
      };
    };
  };
  home.file."./.config/tridactyl/tridactylrc".source = ./tridactylrc;
}


