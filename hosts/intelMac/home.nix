{ config, pkgs, ... }:
let
  args = {
    userAppsPath = "modules/user";
    username = "ray";
    terminal = "alacritty";
    editor = "neovim";
    shell = "zsh";
    browser = "firefox";
    multiplexer = "tmux";
    fuzzyFinder = "fzf";
  };
in
{
  imports = [
    # copies .app to /Applications
    # ../../${args.userAppsPath}/copyApps
    # ../../${args.userAppsPath}/trampoline
    ../../${args.userAppsPath}/direnv
    ../../${args.userAppsPath}/${args.terminal}
    ../../${args.userAppsPath}/${args.editor}
    ../../${args.userAppsPath}/${args.shell}
    # ../../${args.userAppsPath}/${args.browser}
    ../../${args.userAppsPath}/${args.multiplexer}
    ../../${args.userAppsPath}/mtools
    ../../${args.userAppsPath}/${args.fuzzyFinder}
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = args.username;
    homeDirectory = "/Users/${args.username}";
  };

  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 30d";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nixcasks.bitwarden
    nixcasks.obsidian
    nixcasks.vscodium
    nixcasks.webcatalog
    nixcasks.slack
    nixcasks.flameshot
    # raycast
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
