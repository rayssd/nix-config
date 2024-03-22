{ config, pkgs, ... }:

{
  home.file.".mozilla/native-messaging-hosts/tridactyl.json".text = ''
    {
      "name": "tridactyl",
      "description": "Tridactyl native command handler",
      "path": "${pkgs.tridactyl-native}/bin/native_main",
      "type": "stdio",
      "allowed_extensions": [ "tridactyl.vim@cmcaine.co.uk","tridactyl.vim.betas@cmcaine.co.uk", "tridactyl.vim.betas.nonewtab@cmcaine.co.uk" ]
    }
  '';

    # source = /${builtins.unsafeDiscardStringContext pkgs.tridactyl-native}/lib/mozilla/native-messaging-hosts/tridactyl.json;
}
