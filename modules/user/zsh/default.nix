{ config, pkgs, ... }:
let
  myAliases = {
    nixup = "nix flake update --flake ~/nix-config && darwin-rebuild switch --flake ~/nix-config/#$(nix eval --impure --raw --expr 'builtins.currentSystem') |& nom";
    ll = "eza -lh --color=always --group-directories-first --icons=always";
    cat = "bat";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    # syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      # {
      #   name = "vi-mode";
      #   src = pkgs.zsh-vi-mode;
      #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      # }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
    ];
    initExtra = ''
      zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
      '';
  };
}
