{ config, pkgs, ... }:
let
  myAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nix-config/#default";
    drs = "sudo darwin-rebuild switch --flake ~/nix-config/#intelMac";
    hmsl = "home-manager switch --flake ~/nix-config/#loki";
    hmsr = "home-manager switch --flake ~/nix-config/#ray";
    ll = "exa -lh --color=always --group-directories-first";
  };
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    # syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    # completionInit = "autoload -U compinit && compinit -u";
    initExtra = ''
      # preserves zsh command history across tmux windows
      setopt inc_append_history
      setopt share_history

      # ignore duplicate commands
      setopt hist_save_no_dups


      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # bindkey '^I'      autosuggest-accept

      bindkey -v
      # Enable Ctrl-x-e to edit command line
      autoload -U edit-command-line

      # Vi style:
      zle -N edit-command-line
      bindkey '^e' edit-command-line
      bindkey -v '^?' backward-delete-char
      bindkey -M vicmd '^[[1;5C' emacs-forward-word
      bindkey -M vicmd '^[[1;5D' emacs-backward-word
      bindkey -M viins '^[[1;5C' emacs-forward-word
      bindkey -M viins '^[[1;5D' emacs-backward-word

      HISTSIZE=10000000
      SAVEHIST=10000000

      if [[ $+commands[fzf-share] == 1 ]]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi
      '';
  };
}
