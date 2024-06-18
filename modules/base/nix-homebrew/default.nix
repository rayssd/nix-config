{ args, inputs, ... }:

{
  nix-homebrew = {
    user = args.mac.user;
    enable = true;
    taps = with inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-cask-fonts" = homebrew-cask-fonts;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "nikitabobko/homebrew-tap" = homebrew-aerospace;
    };
    mutableTaps = false;
    autoMigrate = false;
  };
}
