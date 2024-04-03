{ args, inputs, ... }:

{
  nix-homebrew = {
    user = args.mac.user;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-cask-fonts" = inputs.homebrew-cask-fonts;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
    autoMigrate = false;
  };
}
