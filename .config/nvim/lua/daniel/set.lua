-- global congifs
vim.g.mapleader = " "
vim.opt.timeoutlen = 2000
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentationk
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- backup settings with vim undoir
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- style
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "CocInlayHint", {bg = "none"})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg= "none"})
vim.api.nvim_set_hl(0, 'TelescopeBackground', {bg= "none"})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg= "none"})
vim.api.nvim_set_hl(0, 'FloatBorder', {bg= "none"})
vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultError', {bg= "none"})
vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultWarning', {bg= "none"})
vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultInformation', {bg= "none"})
vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultHint', {bg= "none"})
vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineWarning', {bg= "none"})
