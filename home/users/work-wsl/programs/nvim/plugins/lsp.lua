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
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float({ source = true }) end, opts)
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
vim.lsp.enable('ts_ls', {})
-- bug with eslint running in html
vim.lsp.config('eslint', {
    filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
})
vim.lsp.enable('eslint')
vim.lsp.enable('rust_analyzer', {
    settings = {
        cargo = {
            buildScripts = {
                enable = true
            }
        }
    }
})
vim.lsp.enable('lua_ls', {})
vim.lsp.enable('angularls', {})
vim.lsp.enable('cssls', {})
vim.lsp.config('emmet_ls', {
    --  current file types plus xml
    filetypes = { "astro", "css", "eruby", "html", "htmlangular", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "templ", "typescriptreact", "vue", "xml" }
})
vim.lsp.enable('emmet_ls', {})
vim.lsp.enable('jsonls', {})
vim.lsp.enable('html', {})
vim.lsp.enable('pyright', {})
vim.lsp.enable('bashls', {})
vim.lsp.enable('yamlls', {})
vim.lsp.enable('dockerls', {})
vim.lsp.enable('nixd', {})
vim.lsp.enable('terraformls', {})


vim.lsp.config('jdtls', {
    settings = {
        java = {
            configuration = {
            },
            completion = {
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                }
            },
            jdt = {
                ls = {
                    lombokSupport = {
                        enabled = true
                    }
                }
            }
        }
    },
    on_attach = function()
        print("starting nvim dap")
        -- require('jdtls.dap').setup_dap_main_class_configs()
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        --breakpoints
        vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
        vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
        vim.keymap.set('n', '<Leader>lp',
            function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
        vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
        vim.keymap.set('n', '<Leader>cb', function() require('dap').clear_breakpoints() end)

        -- breakpoint motions
        vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
        vim.keymap.set('n', '<leader>dj', function() require('dap').step_over() end)
        vim.keymap.set('n', '<leader>dk', function() require('dap').step_into() end)
        vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)

        -- widgets
        vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
            require('dap.ui.widgets').preview()
        end)
        vim.keymap.set('n', '<Leader>df', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set('n', '<Leader>ds', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)
    end
})
vim.lsp.enable('jdtls', {})

-- completion setup
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
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
    }),
})

cmp.setup.filetype({ "sql", "plsql", "mysql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" }
    }
})
