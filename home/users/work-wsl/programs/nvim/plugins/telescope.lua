local builtin = require('telescope.builtin')
require('telescope').setup {
    defaults = {
        layout_strategy = 'vertical',
        path_display = { "truncate" },
    },
}
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fh',  "<cmd>Telescope find_files hidden=true no_ignore=true<CR>",{})
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
