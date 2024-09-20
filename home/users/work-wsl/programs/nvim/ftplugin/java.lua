local workspace_dir = '/mnt/c/Users/daniel.borne/.local/share/eclipse/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local root_markers = { 'gradlew', '.git', 'mvnw', 'pom' }

local config = {
    cmd = {
        '/etc/profiles/per-user/nixos/bin/jdtls'
    },

    root_dir = require('jdtls.setup').find_root(root_markers),

    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = "/etc/profiles/per-user/nixos/lib/openjdk"
                    }
                }
            },
            completion = {
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                }
            }
        }
    },
}

config['init_options'] = {
    bundles = {
      vim.fn.glob('~/.local/lib/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
    }
}

config['on_attach'] = function ()
    print("starting nvim dap")
    -- require('jdtls.dap').setup_dap_main_class_configs()
    require('jdtls').setup_dap({ hotcodereplace = 'auto'})
    --breakpoints
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set('n', '<Leader>cb', function() require('dap').clear_breakpoints() end)

    -- breakpoint motions
    vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
    vim.keymap.set('n', '<leader>dj', function() require('dap').step_over() end)
    vim.keymap.set('n', '<leader>dk', function() require('dap').step_into() end)
    vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)

    -- widgets
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
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

    --help
    -- need to install additional plugin https://github.com/nvim-telescope/telescope-dap.nvim. Trying without it first
    -- vim.keymap.set('n', '<Leader>lb', "<cmd> Telescope dap list_breakpoints<cr>")
    -- vim.keymap.set('n', '<Leader>dch', "<cmd> Telescope dap commands<cr>")
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
