{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard-rs
    waybar
    rofi-wayland
  ];

#  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [ 
        "waybar"
        "export XDG_CURRENT_DESKTOP=gnome"
        "systemctl --user import-environment XDG_CURRENT_DESKTOP WAYLAND_DISPLAY"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      "$mainMod" = "SUPER";
      monitor = ",highres,auto,1";
      env = "XCURSOR_SIZE,24";
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 0;
        touchpad = { 
          natural_scroll = "yes"; 
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };
      decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 10;
        blur = {
          enabled = "yes";
          size = 3;
          passes = 1;
          new_optimizations = "on";
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
          enabled = "yes";

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [ 
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
      };

      dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = "yes"; # you probably want this
      };

      master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true;
      };

      gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = "off";
      };
      
      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      # "device:epic-mouse-v1" = {
      #     sensitivity = -0.5;
      # };

      bind = [
        "$mainMod, T, exec, alacritty"
        "$mainMod, X, killactive, "
        "$mainMod, M, exit, "
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating, "
        "$mainMod, Space, exec, rofi -show drun -show-icons"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ]
      ++ (
        # workspaces
        # Switch workspaces with $mainMod + [0-9]
        # binds $mainMod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
    extraConfig = ''
      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      '';
  };
}
