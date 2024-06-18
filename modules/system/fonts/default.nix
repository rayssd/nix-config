{ pkgs, ... }:

{
  fonts = {
    # fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      sketchybar-app-font
    ];
  };
}
