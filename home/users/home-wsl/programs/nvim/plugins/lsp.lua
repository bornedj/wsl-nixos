local lspconfig = require('lspconfig')

lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Callback function to bind keys for when lsp is attached
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP Actions',
    callback = function(event)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})

-- server configurations
require'lspconfig'.ts_ls.setup({})
require'lspconfig'.eslint.setup({})
require'lspconfig'.rust_analyzer.setup({
    settings = {
        ['rust_analyzer'] = {
            cargo = {
                buildScripts = {
                    enable = true
                }
            }
        }
    }
})
require'lspconfig'.lua_ls.setup({})
require'lspconfig'.angularls.setup({})
require'lspconfig'.cssls.setup({})
require'lspconfig'.emmet_ls.setup({})
require'lspconfig'.jsonls.setup({})
require'lspconfig'.html.setup({})
require'lspconfig'.pyright.setup({})
require'lspconfig'.bashls.setup({})
require'lspconfig'.yamlls.setup({})
require'lspconfig'.dockerls.setup({})
require'lspconfig'.nil_ls.setup({})

-- completion setup
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        {name = 'nvim_lsp'}
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    })
})
