local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- vim-jsbeautify
keymap.set("n", "<leader>jj", ":call RangeJsonBeautify()<CR>")
keymap.set("v", "gq", ":!~/Projects/jp43/jp43.sh<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- AI
keymap.set("v", "<leader>ai", ":AI fix grammar and spelling and replace slang and contractions with a formal academic writing style<CR>", { noremap = true })

-- Not working
-- keymap.set('v', 'gq', vim.lsp.buf.format)
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "K", vim.lsp.buf.hover, opts)
keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)


-- Remove pesky trailing whitespaces
keymap.set('n', '<Leader>wt', [[:%s/\s\+$//e<cr>]])

keymap.set('n', '<F5>', ":lua require('dap').continue()<CR>")
keymap.set("n", "<Leader>dn", ":RustLsp debuggables<CR>")
keymap.set("n", "<F10>", function() require('dap').step_over() end)
keymap.set("n", "<F11>", function() require('dap').step_into() end)
keymap.set("n", "<F12>", function() require('dap').step_out() end)
keymap.set("n", "<Leader>b", function() require('dap').toggle_breakpoint() end)
keymap.set("n", "<Leader>B", function() require('dap').set_breakpoint() end)
keymap.set("n", "<Leader>lp", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
keymap.set("n", "<Leader>dr", function() require('dap').repl.open() end)
keymap.set("n", "<Leader>dl", function() require('dap').run_last() end)
keymap.set("n", "<Leader>du", ":lua require('dapui').toggle()<CR>")

keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
