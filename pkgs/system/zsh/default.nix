{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    # not available in nix-darwin

    # histSize = 10000000; 
    # setOptions = [
    #   # preserve zsh history across tmux windows
    #   "inc_append_history"
    #   "share_history"
    #   # ignore duplicate commands
    #   "hist_save_no_dups"
    # ];

    # not available in nix-darwn
    # enableFzfHistory = true;
    # enableFzfCompletion = true;

    promptInit = ''
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
      else
        [[ ! -f ${./p10k-portable.zsh} ]] || source ${./p10k-portable.zsh}
      fi

      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
}
