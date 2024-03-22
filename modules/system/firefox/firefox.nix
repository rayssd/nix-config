{ pkgs, ... }:

{
  # environment = {
  #   systemPackages = with pkgs; [
  #     tridactyl-native
  #   ];
  # };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    # profiles.default = {
    #   extensions = with pkgs.nur.rycee.firefox-addon; [
    #     ublock-origin
    #     tridactyl
    #   ];
    # };
    nativeMessagingHosts.packages = [ pkgs.tridactyl-native ];
  };
}
