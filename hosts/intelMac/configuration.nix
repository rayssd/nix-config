{ pkgs, inputs, ... }: 

{
  imports = [
    ../../modules/system/zsh
    ../../modules/system/yabai
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPath = [ 
      "/opt/homebrew/bin"
      "~/.local/bin"
    ];
    pathsToLink = [ "/Applications" ];
    systemPackages = with pkgs; [ 
      coreutils

      # LSPs
      deno
      lua-language-server
      marksman
      nil
      rust-analyzer

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
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    # NSGlobalDomain.InitialKeyRepeat = 14;
    # NSGlobalDomain.KeyRepeat = 1;
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ ];
    taps = [ ];
    brews = [ ];
  };
}

