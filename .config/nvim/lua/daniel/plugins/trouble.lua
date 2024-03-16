return {
    "folke/trouble.nvim",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    keys = {
        { "<leader>xx", function() require("trouble").toggle() end, mode = "n"},
        { "<leader>xw",  function() require("trouble").toggle("workspace_diagnostics") end, mode = "n" },
        { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, mode = "n" },
        { "<leader>xq", function() require("trouble").toggle("quickfix") end, mode = "n" },
        { "<leader>xl", function() require("trouble").toggle("loclist") end, mode = "n" },
        { "gR", function() require("trouble").toggle("lsp_references") end, mode = "n" },
        { "<M-n>", function() require("trouble").next({skip_groups = true, jump = true}) end, mode = "n" },
        { "<M-p>", function() require("trouble").previous({skip_groups = true, jump = true}) end, mode = "n" },
    }
}
