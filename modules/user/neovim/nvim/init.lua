local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
 if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
     "git",
     "clone",
     "--filter=blob:none",
     "--single-branch",
     "https://github.com/folke/lazy.nvim.git",
     lazypath,
   })
 end
vim.opt.runtimepath:prepend(lazypath)

vim.g.loaded_python3_provider = 0
vim.g.mapleader = " "

if vim.g.vscode then

  -- vim.cmd[[source $HOME/.config/nvim/vscode/settings.vim]]
  require("lazy").setup("vscode.essentials", {
    performance = {
      rtp = {
        disabled_plugins = {
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "gzip",
          "zip",
          "zipPlugin",
          "tar",
          "tarPlugin",
          "getscript",
          "getscriptPlugin",
          "vimball",
          "vimballPlugin",
          "2html_plugin",
          "logipat",
          "rrhelper",
          -- "spellfile_plugin",
          "matchit",
          "tutor",
          "tohtml"
        },

        dev = {
            path = "~/.local/share/nvim/nix",
            fallback = false,
        }
      }
    }
  })

  require("core")
  -- require("core.keymaps")
  -- require("core.options")

else
  require("lazy").setup("plugins", {
    performance = {
      rtp = {
        disabled_plugins = {
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "gzip",
          "zip",
          "zipPlugin",
          "tar",
          "tarPlugin",
          "getscript",
          "getscriptPlugin",
          "vimball",
          "vimballPlugin",
          "2html_plugin",
          "logipat",
          "rrhelper",
          -- "spellfile_plugin",
          "matchit",
          "tutor",
          "tohtml"
        },

        dev = {
            path = "~/.local/share/nvim/nix",
            fallback = false,
        }
      }
    }
  })

  -- require("lazy").setup("plugins", {
  --   dev = {
  --       path = "~/.local/share/nvim/nix",
  --       fallback = false,
  --   }
  -- })
  require("core")
end

