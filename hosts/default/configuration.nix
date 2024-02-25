# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, ... }:
let
  args = {
    userAppsPath = "modules/user";
    systemAppPath = "modules/system";
    username = "loki";
    shell = "zsh";
    wm = "hyprland";
    browser = "firefox";
    keyremap = "keyd";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../${args.systemAppPath}/${args.keyremap}/${args.keyremap}.nix
      ../../${args.systemAppPath}/${args.wm}/${args.wm}.nix
      ../../${args.systemAppPath}/${args.shell}/${args.shell}.nix
      ../../${args.systemAppPath}/${args.browser}/${args.browser}.nix
      ../../${args.systemAppPath}/fonts/fonts.nix
    ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Enable nix-command & flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [
    "v4l2loopback"
  ];


  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };


  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;

  hardware = {
    # opengl
    opengl.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${args.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "kvm" ]; # Enable ‘sudo’ for the user.
  #  packages = with pkgs; [
  #    firefox
  #    tree
  #  ];
  };


  # This block allows a single command "nixos-rebuild" to also manage home-manager
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     "loki" = import ./home.nix;
  #   };
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      btop
      cmake
      distrobox
      dolphin
      eza
      exercism
      flameshot
      fontconfig
      gh
      git
      home-manager
      jq
      keyd
      obs-studio
      pulseaudio
      ripgrep
      tldr
      unzip
      wireplumber
      wget
      zoom-us

      # Language Servers
      deno
      lua-language-server
      marksman
      nil
      rust-analyzer

      # Programming Languages
      gcc
      python3
      nodejs
      rustup
    ];

    # binsh = "${pkgs.bash}/bin/bash";
    localBinInPath = true;

    sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };

  virtualisation = {
    podman = {
      enable = true;
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    flatpak.enable = true;
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

