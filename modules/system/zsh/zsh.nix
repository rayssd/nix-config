{ pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    promptInit = ''
      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
    '';
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
}
