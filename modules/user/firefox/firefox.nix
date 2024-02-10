{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      userChrome = builtins.readFile ./userChrome.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
  home.file."./.config/tridactyl/tridactylrc".source = ./tridactylrc;
}


