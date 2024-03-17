{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-b";
    keyMode = "vi";
    # terminal = "xterm-256color";
    terminal = "alacritty";
    baseIndex = 1;
    escapeTime = 10;
    historyLimit = 50000;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      { plugin = catppuccin;
        extraConfig = ''

          # Make status bar background transparent
          set-option -g status-style bg=default

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "directory user host session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_directory_text "#{pane_current_path}"

        '';
      }
    ];
    extraConfig = ''

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

      # Stay in copy mode on drag end.
      # (Would use `bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X
      # stop-selection` but it is a bit glitchy.)
      # unbind-key -T copy-mode-vi MouseDragEnd1Pane
      bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-no-clear pbcopy
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-no-clear pbcopy

      # Automatically reorder
      set -g renumber-windows on

      # Swap window
      # bind-key -n C-S-Left swap-window -t -1 \; previous-window
      # bind-key -n C-S-Right swap-window -t +1 \; next-window

      # Moving window
      bind-key -n 'C-S-Tab' select-window -t :-
      bind-key -n 'C-Tab' select-window -t :+
      bind-key -n C-0 select-window -t :0
      bind-key -n C-1 select-window -t :1
      bind-key -n C-2 select-window -t :2
      bind-key -n C-3 select-window -t :3
      bind-key -n C-4 select-window -t :4
      bind-key -n C-5 select-window -t :5
      bind-key -n C-6 select-window -t :6
      bind-key -n C-7 select-window -t :7
      bind-key -n C-8 select-window -t :8
      bind-key -n C-9 select-window -t :9

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      # zsh prompt
      set -ag terminal-overrides ",alacritty:RGB"

      # reload conf
      bind r source-file ~/.config/tmux/tmux.conf \; display ".tmux.conf reloaded!"
      '';
  };
}
