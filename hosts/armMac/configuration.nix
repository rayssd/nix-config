{ config, pkgs, inputs, ... }: 

{
  imports = [
    ../../modules/system/zsh
    ../../modules/system/yabai
    ../../modules/system/skhd
    ../../modules/system/karabiner-elements
    # ../../modules/system/sketchybar
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
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

  users.users."ray" = {
    name = "ray";
    home = "/Users/ray";
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
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      dock.autohide = true;
      NSGlobalDomain.AppleShowAllExtensions = true;
      # NSGlobalDomain.InitialKeyRepeat = 14;
      # NSGlobalDomain.KeyRepeat = 1;
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

