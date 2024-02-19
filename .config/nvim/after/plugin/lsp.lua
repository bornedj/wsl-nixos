local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer',
    'lua_ls',
    'angularls',
    'emmet_ls',
    'cssls',
    'jsonls',
    'html',
    -- 'pylsp',
    'pyright',
    'bashls',
})

lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

-- lsp.set_preferences({
--   sign_icons = {}
-- })

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('lspconfig').eslint.setup{
    settings = {
        format = false
    }
}

require('lspconfig').tsserver.setup{
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "javascript.mjs" }
}

-- disableing pycodestyle
-- require 'lspconfig'.pylsp.setup {
--     on_attach = function(client, bufnr)
--         print('hello pylsp')
--     end,
--     -- on_attach = lsp.on_attach(function(client, bufnr)
--     --     print('hello pylsp')
--     -- end),
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     enabled = false
--                 },
--                 pylint = {
--                     enabled = false
--                 }
--             }
--         }
--     }
-- }

-- lsp.configure('pylsp', {
--     single_file_support = false,
--     on_attach = function(client, bufnr)
--         print('hello pylsp')
--     end,
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     enabled = false,
--                     ignore = { 'E302' }
--                 }
--             }
--         }
--     }
-- })

lsp.setup()
