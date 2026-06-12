require('nvim-treesitter').setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
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
