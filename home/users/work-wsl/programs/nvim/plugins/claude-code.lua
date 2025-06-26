require("claude-code").setup({
    window = {
        position = "vertical",
        split_ratio = 0.5,
    }
})

vim.keymap.set("n", "<leader>cc", '<cmd>ClaudeCode<cr>', {
    desc = "Toggle Claude Code",
})
