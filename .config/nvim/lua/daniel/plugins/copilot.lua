return {
    "github/copilot.vim",
    lazy = true,
    keys = {
        {"<leader>cpe", function () vim.cmd(":Copilot enable") end},
        {"<leader>cpd", function () vim.cmd(":Copilot disable") end}
    },
    config = function ()
       vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\""")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
    end
}
