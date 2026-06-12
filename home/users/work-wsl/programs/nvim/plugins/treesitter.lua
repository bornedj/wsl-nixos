require('nvim-treesitter').setup()

vim.treesitter.language.register('bash', 'sh')
vim.treesitter.language.register('markdown', 'mdx')

-- turns on the highlighting on FileType completion
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

vim.filetype.add({
    extension = {
        mdx = 'jsx'
    }
})
