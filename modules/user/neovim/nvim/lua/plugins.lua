-- add list of plugins to install
return {
  -- lua functions that many plugins use

  -- colorscheme
  "ellisonleao/gruvbox.nvim",

  -- treesitter
  { "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("lazy-configs.treesitter")
    end,
  },

  { "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("lazy-configs.autopairs")
    end,
  },

  --dap

  { "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },

  -- lua line
  "nvim-lualine/lualine.nvim",

  -- essential plugins
  "tpope/vim-surround", -- add, delete, change surroundings (it's awesome)

  -- commenting with gc
  "numToStr/Comment.nvim",

  -- Vimwiki
  {"vimwiki/vimwiki", keys={'<Leader>ww'}},

  -- JS Beautify
  { "maksimr/vim-jsbeautify", event="FuncUndefined" },
  -- { "maksimr/vim-jsbeautify", cmd="RangeJsonBeautify" },
  -- { "maksimr/vim-jsbeautify", keys={'<leader>jj'}},


  -- rainbow paranthesis
  -- "p00f/nvim-ts-rainbow")

  -- highlight unmatched brackets
  "vim-scripts/Highlight-UnMatched-Brackets",

  -- file explorer
  { "nvim-tree/nvim-tree.lua",
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    cmd = "NvimTreeToggle",
    config = function()
      require("lazy-configs.nvim-tree")
    end
  },


  -- fuzzy finding w/ telescope
  { "nvim-telescope/telescope.nvim", branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-lua/plenary.nvim" },
    }, -- dependency for better sorting performance
    config = function()
      require("lazy-configs.telescope")
    end
  }, -- fuzzy finder

  {'mrcjkb/rustaceanvim', version = '^3', -- Recommended
    ft = { 'rust' },
  },

  -- LSP Support
  {'neovim/nvim-lspconfig',
    config = function()
      require("lazy-configs.lsp")
    end
  },

  -- {'williamboman/mason.nvim'},
  -- {'williamboman/mason-lspconfig.nvim'},
  -- Autocompletion
  -- {'hrsh7th/nvim-cmp'},
  -- {'hrsh7th/cmp-buffer'},
  -- {'hrsh7th/cmp-path'},
  -- {'saadparwaiz1/cmp_luasnip'},
  -- {'hrsh7th/cmp-nvim-lsp'},
  -- {'hrsh7th/cmp-nvim-lua'},

  -- Snippets
  -- {'L3MON4D3/LuaSnip'},
  -- {'rafamadriz/friendly-snippets'},
  { "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },

  -- AI

  -- Custom Parameters (with defaults)
  -- { "David-Kunz/gen.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("lazy-configs.gen")
  --   end
  -- },
  -- { "abecodes/tabout.nvim",
  --   event ="InsertEnter",
  --   config = function()
  --     require("lazy-configs.tabout")
  --   end,
  -- }

  { "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}
