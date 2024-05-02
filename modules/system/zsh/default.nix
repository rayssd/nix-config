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

      # ZVM_INIT_MODE=sourcing

      ex () {
        if [ -f $1 ] ; then
          filename=$(echo "$1" | awk -F '.' '{print $1}')

          case $1 in
            *.tar.bz2)   mkdir "$filename" && tar xjf $1 --directory="$filename";;
            *.tar.gz)    mkdir "$filename" && tar xzf $1 --directory="$filename";;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       mkdir "$filename" && tar xf $1 --directory="$filename";;
            *.tbz2)      mkdir "$filename" && tar xjf $1 --directory="$filename";;
            *.tgz)       mkdir "$filename" && tar xzf $1 --directory="$filename";;
            *.zip)       unzip "$1" -d "$filename"     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }

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

      # HISTSIZE=10000000
      # SAVEHIST=10000000

      bindkey "^[[3~" delete-char
      bindkey -a "^[[3~" delete-char

      # FZF theme and config
      export FZF_DEFAULT_OPTS=" \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    '';
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
}
