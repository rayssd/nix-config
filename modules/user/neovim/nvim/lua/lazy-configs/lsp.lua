
-- require('mason').setup()
require('lspconfig').pylsp.setup({
  -- on_attach=on_attach,
  filetypes = {'python'},
  settings = {
    -- configurationSources = {"flake8"},
    -- formatCommand = {"black"},
    pylsp = {
      plugins = {
        -- pyflakes={enabled=true},
        -- pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
        -- pylsp_mypy={enabled=false},
        pycodestyle={
          enabled=true,
          ignore={'E501', 'E231'},
          maxLineLength=120},
        -- yapf={enabled=true}
      }
    }
  }
})

require('lspconfig').lua_ls.setup{
  single_file_support = true,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

require('lspconfig').nil_ls.setup{}

--
-- lsp.configure('denols', {
--   -- on_attach = on_attach,
--   flags = {
--     debounce_text_changes = 150,
--   },
--   filetypes = {
--     'json',
--     'javascript',
--     'javascriptreact',
--     'javascript.jsx',
--     'typescript',
--     'typescriptreact',
--     'typescript.tsx',
--   },
--   single_file_support = true,
--   init_options = {
--     config = vim.fn.expand('$HOME/.dprint.json'),
--     lint = true,
--   },
-- })

-- lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

require("dapui").setup()
-- require("dap").setup()

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
