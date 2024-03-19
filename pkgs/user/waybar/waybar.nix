{ ... }:

{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 0;
        include = ./modules.json;
        modules-left = [
          "custom/appmenuicon"
          "hyprland/workspaces"
          "group/settings"
          "group/quicklinks"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right =  [
          "custom/updates"
          "pulseaudio"
          "bluetooth"
          "battery"
          "network"
          "group/hardware"
          "custom/cliphist"
          "idle_inhibitor"
          "custom/exit"
          "clock"
          "tray"
        ];
      };
    };
  };
}
