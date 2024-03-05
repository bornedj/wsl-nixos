return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        require'nvim-treesitter.configs'.setup {
            ensured_installed = { "help", "javascript", "typescript", "rust", "c", "lua", "vimdoc"},

            sync_install = false,

            auto_install = true,

            highlight = {
                enable = true,

                additional_vim_regex_highlighting = false,
            },
        }
        local ft_to_parser = require("nvim-treesitter.parsers")
        ft_to_parser.mdx = "markdown"
        ft_to_parser.sh = "bash"
        ft_to_parser.java = "java"

        vim.filetype.add({
            extension = {
                mdx = 'jsx'
            }
        })
    end
}
