-- current workaround to install grammers with nix
-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
-- Prevents reinstall of treesitter plugins every boot
vim.opt.runtimepath:append(parser_install_dir)

require('nvim-treesitter.configs').setup({
    ensure_installed = { "javascript", "typescript", "rust", "c", "lua", "vimdoc" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    parser_install_dir = parser_install_dir,
})
local ft_to_parser = require("nvim-treesitter.parsers")
ft_to_parser.mdx = "markdown"
ft_to_parser.sh = "bash"
ft_to_parser.java = "java"

vim.filetype.add({
    extension = {
        mdx = 'jsx'
    }
})
