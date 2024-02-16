vim.filetype.add({
    extension = {
        mdx = 'jsx'
    }
})

local ft_to_parser = require("nvim-treesitter.parsers")
ft_to_parser.mdx = "markdown"
ft_to_parser.sh = "bash"
ft_to_parser.java = "java"
ft_to_parser.mjs = "javascript"
