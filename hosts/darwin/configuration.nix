{ config, pkgs, args, ... }:

{
  imports = [
    ../../${args.systemPkgsPath}/${args.shell}
    ../../${args.systemPkgsPath}/${args.mac.wm}
    ../../${args.systemPkgsPath}/${args.mac.keymapper}
    ../../${args.systemPkgsPath}/${args.mac.vkeyboard}
    # ../../${args.systemPkgsPath}/sketchybar
  ];
  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPath = [
      "~/.local/bin"
    ];
    pathsToLink = [ "/Applications" ];
    systemPackages = with pkgs; [
      coreutils
      btop
      dprint
      eza
      exercism
      fd
      git
      gh
      jq
      lnav
      mongosh
      ollama
      ripgrep
      tealdeer

      # LSPs
      deno
      lua-language-server
      marksman
      nil
      rustup
      python311Packages.python-lsp-server
    ];
  };

  users.users.${args.mac.user} = {
    name = args.mac.user;
    home = "/Users/${args.mac.user}";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix = {
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      interval = { Weekday = 7; Hour = 0; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog

  # The platform the configuration will be used on.
  # nixpkgs.hostPlatform = "x86_64-darwin";

  system = {
    stateVersion = 4;
    defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      dock = {
        autohide = false;
        # show-recents = false;
        # launchanim = true;
        # mouse-over-hilite-stack = true;
        orientation = "right";
        # tilesize = 48;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        # InitialKeyRepeat = 14;
        # KeyRepeat = 1;
        "com.apple.mouse.tapBehavior" = 1;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

  };

  homebrew = {
    enable = true;
    # onActivation = {
    #   cleanup = "uninstall";
      # autoUpdate = true;
      # upgrade = true;
    # };
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      "firefox"
      "raycast"
      "hiddenbar"
      "maccy"
      "scroll-reverser"
      "stats"
      "wireshark"
      "zoom"
      "microsoft-teams"
      "gpg-suite-no-mail"
    ];
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [ ];
  };
}

