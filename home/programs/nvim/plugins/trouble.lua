vim.keymap.set("n", "<leader>xx", require("trouble").toggle())
vim.keymap.set("n", "<leader>xw", require("trouble").toggle("workspace_diagnostics"))
vim.keymap.set("n", "<leader>xd", require("trouble").toggle("document_diagnostics"))
vim.keymap.set("n", "<leader>xq", require("trouble").toggle("quickfix"))
vim.keymap.set("n", "<leader>xl", require("trouble").toggle("loclist"))
vim.keymap.set("n", "gR", require("trouble").toggle("lsp_references"))
vim.keymap.set("n", "<M-n>", require("trouble").next({skip_groups = true, jump = true}))
vim.keymap.set("n", "<M-p>", require("trouble").previous({skip_groups = true, jump = true}))