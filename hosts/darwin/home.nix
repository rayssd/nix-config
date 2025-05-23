{ config, pkgs, args, ... }:
{
  imports = [
    ../../${args.userModulesPath}/direnv
    ../../${args.userModulesPath}/${args.terminal}
    ../../${args.userModulesPath}/${args.editor}
    ../../${args.userModulesPath}/${args.shell}
  # ../../${args.userModulesPath}/${args.browser}
    ../../${args.userModulesPath}/${args.multiplexer}
  # ../../${args.userModulesPath}/mtools
    ../../${args.userModulesPath}/bat
    ../../${args.userModulesPath}/zoxide
    ../../${args.userModulesPath}/lnav
    ../../${args.userModulesPath}/${args.mac.vkeyboard}
    ../../${args.userModulesPath}/${args.fuzzyFinder}
    ../../${args.userModulesPath}/${args.mac.bar}
    ../../${args.userModulesPath}/${args.mac.wm}
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = args.mac.user;
    homeDirectory = "/Users/${args.mac.user}";
  };

  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 15d";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nixcasks.bitwarden
    nixcasks.obsidian
    nixcasks.vscodium
    nixcasks.webcatalog
    nixcasks.flameshot
    nixcasks.android-file-transfer
    nixcasks.vlc
    # nixcasks.superproductivity
    # nixcasks.firefox
    nixcasks.omnidisksweeper
    nixcasks.zen
    raycast
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/loki/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # MOZ_LEGACY_PROFILES = 1; #useless :(
    # EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    #   toLua = str: "lua << EOF\n${str}\nEOF\n";
    #   toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";

  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
