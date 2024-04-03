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
        search = {
          default = "Whoogle";
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };

            "MongoDB Docs" = {
              urls = [{ template = "https://www.mongodb.com/docs/search?q={searchTerms}"; }];
              definedAliases = [ "docs" ];
            };

            "Knowledge.find()" = {
              urls = [{ template = "https://search.corp.mongodb.com/#q={searchTerms}&sort=relevancy"; }];
              definedAliases = [ "kf" ];
            };

            "Whoogle" = {
              urls = [{ template = "https://lokiunifi.duckdns.org/search?q={searchTerms}"; }];
              definedAliases = [ "" ];
            };

            "MyNixOS.com" = {
              urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
              definedAliases = [ "nix" ];
            };

            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };

        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
          "signon.rememberSignons" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;

          "app.update.auto" = false;
          "app.normandy.enabled" = false;
          "beacon.enabled" = false;
          # "browser.startup.homepage" = "https://lobste.rs";
          "browser.search.region" = "AU";
          "browser.search.countryCode" = "AU";
          "browser.search.hiddenOneOffs" = "Google,Amazon.com,Bing";
          # "browser.search.isUS" = false;
          "browser.ctrlTab.recentlyUsedOrder" = false;
          # "browser.newtabpage.enabled" = false;
          "browser.bookmarks.showMobileBookmarks" = true;
          # "browser.uidensity" = 1;
          "browser.urlbar.update" = true;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "distribution.searchplugins.defaultLocale" = "en-AU";
          "extensions.getAddons.cache.enabled" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.pocket.enabled" = false;
          "extensions.webservice.discoverURL" = "";
          "general.useragent.locale" = "en-AU";
          # "identity.fxaccounts.account.device.name" = config.networking.hostName;
          # "intl.accept_languages" = "en-GB, en";
          # "intl.locale.requested" = "en-GB,en-US";
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
          "reader.color_scheme" = "auto";
          "services.sync.declinedEngines" = "addons,passwords,prefs";
          "services.sync.engine.addons" = false;
          "services.sync.engineStatusChanged.addons" = true;
          "services.sync.engine.passwords" = false;
          "services.sync.engine.prefs" = false;
          "services.sync.engineStatusChanged.prefs" = true;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.updatePing.enabled" = false;
        };
      };
    };
  };
  home.file."./.config/tridactyl/tridactylrc".source = ./tridactylrc;
}


