{ config, pkgs, ... }:
let
  # treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.c
        p.lua
        p.nix
        p.bash
        p.cpp
        p.json
        p.javascript
        p.python
        p.markdown
  ]);
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      treesitter
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitter;
  };
}
