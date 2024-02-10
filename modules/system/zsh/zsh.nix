{ pkgs, ... }:
{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    histSize = 10000000;
    setOptions = [
      # preserve zsh history across tmux windows
      "inc_append_history"
      "share_history"
      # ignore duplicate commands
      "hist_save_no_dups"
    ];
    promptInit = ''
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
      else
        [[ ! -f ${./p10k-portable.zsh} ]] || source ${./p10k-portable.zsh}
      fi
    '';
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
}
