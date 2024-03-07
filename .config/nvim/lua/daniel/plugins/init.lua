return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary",
    },
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
        keys = {
            {"<leader>u",function () vim.cmd.UndotreeToggle end, desc = "Open undotree", mode = "n"}
        }
    },
    'christoomey/vim-tmux-navigator',
    'mfussenegger/nvim-jdtls',
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
