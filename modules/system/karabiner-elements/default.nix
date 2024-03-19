{ ... }:

{
  services.karabiner-elements.enable = true;
  home.file.".config/karabiner/assets/complex_modifications/MyCustomMods.json".source = ./MyCustomMods.json;
  home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
}
