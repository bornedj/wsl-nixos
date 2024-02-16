vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    --packer manages itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        -- or				, branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {"rebelot/kanagawa.nvim"}
    use { "catppuccin/nvim", as = "catppuccin" }
    use({'rose-pine/neovim', as = 'rose-pine'})
    use({ 'rmehri01/onenord.nvim', as = "onenord"})
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
            },
            { 'williamboman/mason-lspconfig.nvim' },
            -- autocompletiohttps://github.com/epwalsh/obsidian.nvim#using-packernvimn
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use('christoomey/vim-tmux-navigator')
    use('mfussenegger/nvim-jdtls')
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } vim.g.mkdp_theme = "light" end,
        ft = { "markdown" },
    })
    use('mfussenegger/nvim-dap')
    use('David-Kunz/jester')
    use('nvim-tree/nvim-web-devicons')
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
        },
    })
    use({
        "scalameta/nvim-metals",
        requires = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
        },
    })
end)

