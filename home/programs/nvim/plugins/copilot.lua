vim.keymap.set('n', "<leader>cpe", vim.cmd(":Copilot enable"))
vim.keymap.set('n', "<leader>cpd", vim.cmd(":Copilot disable"))
vim.keymap.set('i', '<C-y>', 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
