require('nvim-treesitter').setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("bash", "sh")
vim.treesitter.language.register("java", "java")

vim.filetype.add({
    extension = {
        mdx = 'jsx'
    }
})
