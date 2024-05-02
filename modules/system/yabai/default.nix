{ pkgs, ... }:

{
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      mouse_follows_focus="off";
      focus_follows_mouse="off";
      window_placement="second_child";
      window_topmost="off";
      window_shadow="on";
      window_opacity="off";
      # window_opacity_duration=0.0;
      # active_window_opacity=1.0;
      # normal_window_opacity=0.8;
      # menubar_opacity=0.0;
      insert_feedback_color="0xffd75f5f";
      split_ratio=0.50;
      auto_balance="off";
      mouse_modifier="fn";
      mouse_action1="move";
      mouse_action2="resize";
      mouse_drop_action="swap";

      # general space settings
      layout="bsp";
      top_padding=10;
      bottom_padding=10;
      left_padding=10;
      right_padding=10;
      window_gap=10;
    };

    extraConfig = ''
      # yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      # sudo yabai --load-sa

      # ===== Rules ==================================

      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      # yabai -m rule --add label="Finder" app="^Finder$" title=".*" manage=off
      yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
      yabai -m rule --add label="macfeh" app="^macfeh$" manage=off
      yabai -m rule --add label="System Preferences" app="^System Preferences$" title=".*" manage=off
      yabai -m rule --add label="System Settings" app="^System Settings$" title=".*" manage=off
      yabai -m rule --add label="App Store" app="^App Store$" manage=off
      yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      yabai -m rule --add label="KeePassXC" app="^KeePassXC$" manage=off
      yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      yabai -m rule --add label="mpv" app="^mpv$" manage=off
      yabai -m rule --add label="Software Update" title="Software Update" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      yabai -m rule --add label="Zoom" app="zoom.us" title=".*" manage=off
      yabai -m rule --add label="OBS" app="OBS" title=".*" manage=off space=3
      yabai -m rule --add label="EventViewer" app="EventViewer" title="EventViewer" manage=off
      yabai -m rule --add label="Archive Utility" app="Archive Utility" title=".*" manage=off
      # yabai -m rule --add label="lv" app="lv" title=".*" manage=off
      yabai -m rule --add label="Stats" app="Stats" title=".*" manage=off
      yabai -m rule --add label="Okta Verify" app="^Okta Verify$" title=".*" manage=off
      yabai -m rule --add label="E-book Viewer" app="^E-book Viewer$" title=".*" manage=off
      yabai -m rule --add label="Microsoft Teams" app="^Microsoft Teams.*$" title=".*" manage=off
      yabai -m rule --add label="AnyConnect" app="^.*AnyConnect.*$" title=".*" manage=off

      # App placement rules
      yabai -m rule --add label="Firefox" app="^Firefox$" title=".*" space=1
      yabai -m rule --add label="Obsidian" app="^Obsidian$" title=".*" space=3
      yabai -m rule --add label="Slack" app="^Slack$" title=".*" space=4
      yabai -m rule --add label="t2" app="^t2$" title=".*" space=5
      yabai -m rule --add label="Support Hub" app="^Support Hub$" title=".*" space=7

      # ===== Signals =================================

      # yabai -m signal -add event=application_activated action="echo \"application ID \$YABAI_PROCESS_ID activated\""

      # focus window after active space changes
      # yabai -m signal --add event=space_changed action="yabai -m window --focus \$(yabai -m query --windows --space | jq '.[-1].id')"
      #
      # focus window after active display changes
      # yabai -m signal --add event=display_changed action="yabai -m window --focus \$(yabai -m query --windows --space | jq '.[-1].id')"

      # ===== External Bars ===========================

      # add 32 padding to the top or bottom of all spaces regardless of the display it belongs to
      yabai -m config external_bar all:32:0

      # For rules to apply to windows that are already opened before yabai is launched or this rule is added
      yabai -m rule --apply

      # Add borders to windows. colour format 0xAARRGGBB
      borders active_color=0xffb4befe inactive_color=0x55b4befe width=5.0 hidpi=on blur_radius=5.0 &
    '';
  };
}
