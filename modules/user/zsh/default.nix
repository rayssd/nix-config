{ config, pkgs, ... }:
let
  myAliases = {
    nixup = "nix flake update ~/nix-config && sleep 2 && darwin-rebuild switch --flake ~/nix-config/#$(nix eval --impure --raw --expr 'builtins.currentSystem')";
    ll = "eza -lh --color=always --group-directories-first";
    cat = "bat";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
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
      # preserves zsh command history across tmux windows
      setopt inc_append_history
      setopt share_history

      # ignore duplicate commands
      setopt hist_save_no_dups

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      bindkey -v

      # Enable Ctrl-x-e to edit command line
      autoload -U edit-command-line

      # Vi style:
      zle -N edit-command-line
      bindkey '^e' edit-command-line
      bindkey -v '^?' backward-delete-char
      bindkey -v '^H' backward-delete-char
      bindkey -M vicmd '^[[1;5C' emacs-forward-word
      bindkey -M vicmd '^[[1;5D' emacs-backward-word
      bindkey -M viins '^[[1;5C' emacs-forward-word
      bindkey -M viins '^[[1;5D' emacs-backward-word

      HISTSIZE=10000000
      SAVEHIST=10000000

      bindkey "^[[3~" delete-char
      bindkey -a "^[[3~" delete-char
     
      # FZF theme and config
      export FZF_DEFAULT_OPTS=" \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

      if [[ $+commands[fzf-share] == 1 ]]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi
      '';
  };
}
