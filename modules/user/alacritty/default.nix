{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "alacritty";
      font = {
        size = 18;
        normal.family = "FiraCode Nerd Font";
      };
      window = {
        decorations = "Buttonless";
        dynamic_title = true;
        opacity = 0.8;
        padding.x = 15;
        padding.y = 15;
      };
      keyboard = {
        bindings = [
          { chars = "\\u001Ba"; key = "A"; mods = "Alt"; }
          { chars = "\\u001Bb"; key = "B"; mods = "Alt"; }
          { chars = "\\u001Bc"; key = "C"; mods = "Alt"; }
          { chars = "\\u001Bd"; key = "D"; mods = "Alt"; }
          { chars = "\\u001Be"; key = "E"; mods = "Alt"; }
          { chars = "\\u001Bf"; key = "F"; mods = "Alt"; }
          { chars = "\\u001Bg"; key = "G"; mods = "Alt"; }
          { chars = "\\u001Bh"; key = "H"; mods = "Alt"; }
          { chars = "\\u001Bi"; key = "I"; mods = "Alt"; }
          { chars = "\\u001Bj"; key = "J"; mods = "Alt"; }
          { chars = "\\u001Bk"; key = "K"; mods = "Alt"; }
          { chars = "\\u001Bl"; key = "L"; mods = "Alt"; }
          { chars = "\\u001Bm"; key = "M"; mods = "Alt"; }
          { chars = "\\u001Bn"; key = "N"; mods = "Alt"; }
          { chars = "\\u001Bo"; key = "O"; mods = "Alt"; }
          { chars = "\\u001Bp"; key = "P"; mods = "Alt"; }
          { chars = "\\u001Bq"; key = "Q"; mods = "Alt"; }
          { chars = "\\u001Br"; key = "R"; mods = "Alt"; }
          { chars = "\\u001Bs"; key = "S"; mods = "Alt"; }
          { chars = "\\u001Bt"; key = "T"; mods = "Alt"; }
          { chars = "\\u001Bu"; key = "U"; mods = "Alt"; }
          { chars = "\\u001Bv"; key = "V"; mods = "Alt"; }
          { chars = "\\u001Bw"; key = "W"; mods = "Alt"; }
          { chars = "\\u001Bx"; key = "X"; mods = "Alt"; }
          { chars = "\\u001By"; key = "Y"; mods = "Alt"; }
          { chars = "\\u001Bz"; key = "Z"; mods = "Alt"; }
          { chars = "\\u001BA"; key = "A"; mods = "Alt|Shift"; }
          { chars = "\\u001BB"; key = "B"; mods = "Alt|Shift"; }
          { chars = "\\u001BC"; key = "C"; mods = "Alt|Shift"; }
          { chars = "\\u001BD"; key = "D"; mods = "Alt|Shift"; }
          { chars = "\\u001BE"; key = "E"; mods = "Alt|Shift"; }
          { chars = "\\u001BF"; key = "F"; mods = "Alt|Shift"; }
          { chars = "\\u001BG"; key = "G"; mods = "Alt|Shift"; }
          { chars = "\\u001BH"; key = "H"; mods = "Alt|Shift"; }
          { chars = "\\u001BI"; key = "I"; mods = "Alt|Shift"; }
          { chars = "\\u001BJ"; key = "J"; mods = "Alt|Shift"; }
          { chars = "\\u001BK"; key = "K"; mods = "Alt|Shift"; }
          { chars = "\\u001BL"; key = "L"; mods = "Alt|Shift"; }
          { chars = "\\u001BM"; key = "M"; mods = "Alt|Shift"; }
          { chars = "\\u001BN"; key = "N"; mods = "Alt|Shift"; }
          { chars = "\\u001BO"; key = "O"; mods = "Alt|Shift"; }
          { chars = "\\u001BP"; key = "P"; mods = "Alt|Shift"; }
          { chars = "\\u001BQ"; key = "Q"; mods = "Alt|Shift"; }
          { chars = "\\u001BR"; key = "R"; mods = "Alt|Shift"; }
          { chars = "\\u001BS"; key = "S"; mods = "Alt|Shift"; }
          { chars = "\\u001BT"; key = "T"; mods = "Alt|Shift"; }
          { chars = "\\u001BU"; key = "U"; mods = "Alt|Shift"; }
          { chars = "\\u001BV"; key = "V"; mods = "Alt|Shift"; }
          { chars = "\\u001BW"; key = "W"; mods = "Alt|Shift"; }
          { chars = "\\u001BX"; key = "X"; mods = "Alt|Shift"; }
          { chars = "\\u001BY"; key = "Y"; mods = "Alt|Shift"; }
          { chars = "\\u001BZ"; key = "Z"; mods = "Alt|Shift"; }
          { chars = "\\u001B1"; key = "Key1"; mods = "Alt"; }
          { chars = "\\u001B2"; key = "Key2"; mods = "Alt"; }
          { chars = "\\u001B3"; key = "Key3"; mods = "Alt"; }
          { chars = "\\u001B4"; key = "Key4"; mods = "Alt"; }
          { chars = "\\u001B5"; key = "Key5"; mods = "Alt"; }
          { chars = "\\u001B6"; key = "Key6"; mods = "Alt"; }
          { chars = "\\u001B7"; key = "Key7"; mods = "Alt"; }
          { chars = "\\u001B8"; key = "Key8"; mods = "Alt"; }
          { chars = "\\u001B9"; key = "Key9"; mods = "Alt"; }
          { chars = "\\u001B0"; key = "Key0"; mods = "Alt"; }
          { chars = "\\u0000"; key = "Space"; mods = "Control"; }
          { chars = "\\u001B`"; key = "`"; mods = "Alt"; }
          { chars = "\\u001B~"; key = "`"; mods = "Alt|Shift"; }
          { chars = "\\u001B."; key = "Period"; mods = "Alt"; }
          { chars = "\\u001B*"; key = "Key8"; mods = "Alt|Shift"; }
          { chars = "\\u001B#"; key = "Key3"; mods = "Alt|Shift"; }
          { chars = "\\u001B>"; key = "Period"; mods = "Alt|Shift"; }
          { chars = "\\u001B<"; key = "Comma"; mods = "Alt|Shift"; }
          { chars = "\\u001B_"; key = "Minus"; mods = "Alt|Shift"; }
          { chars = "\\u001B%"; key = "Key5"; mods = "Alt|Shift"; }
          { chars = "\\u001B^"; key = "Key6"; mods = "Alt|Shift"; }
          { chars = "\\u001B\\\\"; key = "Backslash"; mods = "Alt"; }
          { chars = "\\u001B|"; key = "Backslash"; mods = "Alt|Shift"; }
          { chars = "\\u001B;"; key = "Semicolon"; mods = "Alt"; }
          { chars = "\\u001B[1;5l"; key = "Comma"; mods = "Control"; }
          { chars = "\\u001B[1;5n"; key = "Period"; mods = "Control"; }
          { chars = "\\u001B[27;5;9~"; key = "Tab"; mods = "Control"; }
          { chars = "\\u001B[27;5;48~"; key = "0"; mods = "Control"; }
          { chars = "\\u001B[27;5;49~"; key = "1"; mods = "Control"; }
          { chars = "\\u001B[27;5;50~"; key = "2"; mods = "Control"; }
          { chars = "\\u001B[27;5;51~"; key = "3"; mods = "Control"; }
          { chars = "\\u001B[27;5;52~"; key = "4"; mods = "Control"; }
          { chars = "\\u001B[27;5;53~"; key = "5"; mods = "Control"; }
          { chars = "\\u001B[27;5;54~"; key = "6"; mods = "Control"; }
          { chars = "\\u001B[27;5;55~"; key = "7"; mods = "Control"; }
          { chars = "\\u001B[27;5;56~"; key = "8"; mods = "Control"; }
          { chars = "\\u001B[27;5;57~"; key = "9"; mods = "Control"; }
          { chars = "\\u001B[1;5D"; key = "Left"; mods = "Control"; }
          { chars = "\\u001B[1;5C"; key = "Right"; mods = "Control"; }
        ];
      };

      colors = {
        primary = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          dim_foreground = "#CDD6F4";
          bright_foreground = "#CDD6F4";
        };

        cursor = {
          text = "#1E1E2E";
          cursor = "#F5E0DC";
        };

        vi_mode_cursor = {
          text = "#1E1E2E";
          cursor = "#B4BEFE";
        };

        search = {
          matches = {
            foreground = "#1E1E2E";
            background = "#A6ADC8";
          };

          focused_match = {
            foreground = "#1E1E2E";
            background = "#A6E3A1";
          };
        };

        footer_bar = {
          foreground = "#1E1E2E";
          background = "#A6ADC8";
        };

        hints = {
          start = {
            foreground = "#1E1E2E";
            background = "#F9E2AF";
          };


          end = {
            foreground = "#1E1E2E";
            background = "#A6ADC8";
          };
        };

        selection = {
          text = "#1E1E2E";
          background = "#F5E0DC";
        };

        normal = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };

        bright = {
          black = "#585B70";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#A6ADC8";
        };

        dim = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };

        indexed_colors = [
        {
          index = 16;
          color = "#FAB387";
        }
        {
          index = 17;
          color = "#F5E0DC";
        }];
      };
    };
  };
}
