return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    -- not sure why the below setup options are not being merged into the 
    -- final spec. Need to look into this later.
    -- opts = {
    --     defaults = {
    --         layout_strategy = 'center',
    --         path_display = { "truncate" },
    --     },
    -- },
    config = function()
        local builtin = require('telescope.builtin')
        -- remove once I've found how to implement through `opts`
        require('telescope').setup {
            defaults = {
                layout_strategy = 'vertical',
                path_display = { "truncate" },
            },
        }
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fh', builtin.find_files, {hidden = true, no_ignore = true})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        -- grep commits
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
        -- grep branches
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
