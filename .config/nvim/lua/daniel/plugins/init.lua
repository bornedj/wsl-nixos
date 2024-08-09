return {
    "nvim-lua/plenary.nvim",
    {
        "folke/trouble.nvim",
        config = function ()
            require("trouble").setup {
                icons = false
            }
        end
    },
    "neovim/nvim-lspconfig",
    "folke/which-key.nvim",
    {
        'mbbill/undotree',
        lazy = false,
        config = function ()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false,
    },
    'mfussenegger/nvim-jdtls',
    "mfussenegger/nvim-dap",
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    'David-Kunz/jester',
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
        },
    },
}
