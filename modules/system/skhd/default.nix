{ ... }:

{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # opens iTerm2
      # fn - return : "''${HOME}"/.config/yabai/scripts/open_iterm2.sh

      # Focus space
      # fn - h : yabai -m space --focus prev && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - l : yabai -m space --focus next && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 1 : yabai -m space --focus 1 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 2 : yabai -m space --focus 2 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 3 : yabai -m space --focus 3 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 4 : yabai -m space --focus 4 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 5 : yabai -m space --focus 5 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 6 : yabai -m space --focus 6 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 7 : yabai -m space --focus 7 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 8 : yabai -m space --focus 8 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')
      # fn - 9 : yabai -m space --focus 9 && yabai -m window --focus $(yabai -m query --windows --space | jq '.[-1].id')

      # fn - h : yabai -m space --focus prev && yabai -m window --focus prev
      # fn - l : yabai -m space --focus next && yabai -m window --focus next
      # fn - 1 : yabai -m space --focus 1 && yabai -m window --focus 1
      # fn - 2 : yabai -m space --focus 2 && yabai -m window --focus 2
      # fn - 3 : yabai -m space --focus 3 && yabai -m window --focus 3
      # fn - 4 : yabai -m space --focus 4 && yabai -m window --focus 4
      # fn - 5 : yabai -m space --focus 5 && yabai -m window --focus 5
      # fn - 6 : yabai -m space --focus 6 && yabai -m window --focus 6
      # fn - 7 : yabai -m space --focus 7 && yabai -m window --focus 7
      # fn - 8 : yabai -m space --focus 8 && yabai -m window --focus 8
      # fn - 9 : yabai -m space --focus 9 && yabai -m window --focus 9

      # Focus windows
      fn - u : yabai -m window --focus prev
      fn - i : yabai -m window --focus next

      # Moving windows
      shift + fn - u : yabai -m window --warp prev
      shift + fn - i : yabai -m window --warp next

      # Focus display
      fn - 0x2B : yabai -m display --focus west
      fn - 0x2F : yabai -m display --focus east

      # Moving windows across displays  0x2B = , |  0x2F = .
      shift + fn - 0x2B : yabai -m window --display west; yabai -m display --focus west
      shift + fn - 0x2F : yabai -m window --display east; yabai -m display --focus east

      # Window Operation
      fn - x : yabai -m window --close

      # Float / Unfloat window
      fn - f : \
          yabai -m window --toggle float; \
          yabai -m window --toggle border

      # Make window native fullscreen
      shift + fn - m         : yabai -m window --toggle native-fullscreen
      fn - m                 : yabai -m window --toggle zoom-fullscreen

      # Move focus container to workspace
      # shift + fn - h : yabai -m window --space prev; yabai -m space --focus prev
      # shift + fn - l : yabai -m window --space next; yabai -m space --focus next
      # shift + fn - 1 : yabai -m window --space 1 && yabai -m space --focus 1
      # shift + fn - 2 : yabai -m window --space 2 && yabai -m space --focus 2
      # shift + fn - 3 : yabai -m window --space 3 && yabai -m space --focus 3
      # shift + fn - 4 : yabai -m window --space 4 && yabai -m space --focus 4
      # shift + fn - 5 : yabai -m window --space 5 && yabai -m space --focus 5
      # shift + fn - 6 : yabai -m window --space 6 && yabai -m space --focus 6
      # shift + fn - 7 : yabai -m window --space 7 && yabai -m space --focus 7
      # shift + fn - 8 : yabai -m window --space 8 && yabai -m space --focus 8
      # shift + fn - 9 : yabai -m window --space 9 && yabai -m space --focus 9
      shift + fn - y : yabai -m window --space prev
      shift + fn - o : yabai -m window --space next
      shift + fn - 1 : yabai -m window --space 1
      shift + fn - 2 : yabai -m window --space 2
      shift + fn - 3 : yabai -m window --space 3
      shift + fn - 4 : yabai -m window --space 4
      shift + fn - 5 : yabai -m window --space 5
      shift + fn - 6 : yabai -m window --space 6
      shift + fn - 7 : yabai -m window --space 7
      shift + fn - 8 : yabai -m window --space 8
      shift + fn - 9 : yabai -m window --space 9
      shift + fn - 0 : yabai -m window --space 10

      # Resize windows
      ctrl + fn - y : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0
      ctrl + fn - u : yabai -m window --resize bottom:0:50 && yabai -m window --resize top:0:50
      ctrl + fn - i : yabai -m window --resize top:0:-50 && yabai -m window --resize bottom:0:-50
      ctrl + fn - o : yabai -m window --resize right:-50:0 && yabai -m window --resize left:-50:0

      # Equalize size of windows
      fn - b : yabai -m space --balance

      # Enable / Disable gaps in current workspace
      ctrl + fn - g : yabai -m space --toggle padding; yabai -m space --toggle gap

      # Rotate windows clockwise and anticlockwise
      fn - r         : yabai -m space --rotate 270
      shift + fn - r : yabai -m space --rotate 90

      # Rotate on X and Y Axis
      shift + fn - x : yabai -m space --mirror x-axis
      shift + fn - y : yabai -m space --mirror y-axis

      # Set insertion point for focused container
      shift + ctrl + fn - y : yabai -m window --insert west
      shift + ctrl + fn - u : yabai -m window --insert south
      shift + ctrl + fn - i : yabai -m window --insert north
      shift + ctrl + fn - o : yabai -m window --insert east


      # Restart Yabai
      shift + ctrl + fn - r : \
          /usr/bin/env osascript <<< \
              "display notification \"Restarting Yabai\" with title \"Yabai\""; \
          launchctl kickstart -k "gui/''${UID}/org.nixos.yabai" && \
          yabai -m rule --apply
    '';
  };
}
