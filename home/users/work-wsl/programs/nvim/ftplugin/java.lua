local workspace_dir = '/mnt/c/Users/daniel.borne/.local/share/eclipse/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local root_markers = { 'gradlew', '.git', 'mvnw', 'pom' }

-- Find the latest Lombok JAR from Maven cache
local function find_lombok_jar()
    local lombok_jars = vim.fn.glob(os.getenv('HOME') .. '/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar', 0, 1)
    if type(lombok_jars) == 'table' and #lombok_jars > 0 then
        return lombok_jars[#lombok_jars]
    end
    return nil
end

local lombok_jar = find_lombok_jar()

local cmd = {
    '/etc/profiles/per-user/nixos/bin/jdtls'
}

if lombok_jar then
    table.insert(cmd, '--jvm-arg=-javaagent:' .. lombok_jar)
end

local config = {
    cmd = cmd,

    root_dir = require('jdtls.setup').find_root(root_markers),

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
