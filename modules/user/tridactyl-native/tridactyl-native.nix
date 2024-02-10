{ config, pkgs, ... }:

{
  home.file.".mozilla/native-messenger-hosts/tridactyl.json".source = {
    source = "${pkgs.tridactyl-native}/lib/mozilla/native-messaging-hosts/tridactyl.json";
  };
}
