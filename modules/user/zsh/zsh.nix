{ config, pkgs, ... }:
let
  myAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-config/#default";
    hms = "home-manager switch --flake ~/nixos-config/#loki";
    ll = "exa -lh --color=always --group-directories-first";
  };
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = ''

      if [[ $+commands[fzf-share] == 1 ]]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

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

      SAVEHIST=10000000
      '';
  };
}
