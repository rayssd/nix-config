{ config, pkgs, args, ... }:

{
  imports = [
    ../../${args.systemModulesPath}/${args.shell}
    ../../${args.systemModulesPath}/${args.mac.wm}
    ../../${args.systemModulesPath}/${args.mac.keymapper}
    ../../${args.systemModulesPath}/${args.mac.vkeyboard}
    ../../${args.systemModulesPath}/fonts
    ../../${args.systemModulesPath}/sketchybar
  ];
  environment = {
    shells = with pkgs; [ bash zsh ];
    # loginShell throws error as of 05-Nov-2024
    # loginShell = pkgs.zsh;
    systemPath = [
      "~/.local/bin"
      "/opt/homebrew/bin"
    ];
    pathsToLink = [ "/Applications" ];
    systemPackages = with pkgs; [
      # coreutils
      btop
      lua5_4
      dprint
      eza
      exercism
      jankyborders
      fd
      git
      gh
      jq
      lnav
      nodejs-slim_22
      nix-output-monitor
      mongosh
      ripgrep
      tealdeer
      unrar
      pipx

      # LSPs
      deno
      lua-language-server
      marksman
      nil
      rustup
      # python311Packages.python-lsp-server
    ];
  };

  users.users.${args.mac.user} = {
    name = args.mac.user;
    home = "/Users/${args.mac.user}";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  security.pam.enableSudoTouchIdAuth = true;

  # Necessary for using flakes on this system.
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      extra-nix-path = "nixpkgs=flake:nixpkgs";
    };
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 15d";
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
    startup.chime = false;
    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        AppleShowAllFiles = true;
        CreateDesktop = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        # QuitMenuItem = false;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
      dock = {
        autohide = true;
        # show-recents = false;
        # launchanim = true;
        # mouse-over-hilite-stack = true;
        orientation = "right";
        tilesize = 36;
        static-only = true;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        # InitialKeyRepeat = 14;
        # KeyRepeat = 1;
        "com.apple.mouse.tapBehavior" = 1;
      };

      # CustomUserPreferences = {
      #   "com.apple.spaces" = {
      #     "spans-displays" = false;
      #   };
      # };

      magicmouse = {
        MouseButtonMode = "TwoButton";
      };

      spaces = {
        spans-displays = false;
      };

      # With SIP enabled, this does not work with error:
      # defaults[95085:278887] Could not write domain com.apple.universalaccess; exiting
      # universalaccess = {
      #   reduceMotion = true;
      #   reduceTransparency = false;
      # };

    };

    # Doesn't seem to have any effect with Karabiner installed
    # keyboard = {
    #   enableKeyMapping = true;
    #   remapCapsLockToEscape = true;
    # };


  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      autoUpdate = true;
      upgrade = true;
    };
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      # "maccy"
      "scroll-reverser"
      "wireshark"
      "microsoft-teams"
      "gpg-suite-no-mail"
      "megasync"
      "homebrew/cask-fonts/font-sf-mono"
      "homebrew/cask-fonts/font-sf-pro"
      # "nikitabobko/tap/aerospace"
      "sf-symbols"
      # "raycast"
      "webex"
      "anytype"
      # "karabiner-elements"
    ];
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [ ];
  };
}

