local workspace_dir = '/mnt/c/Users/daniel.borne/.local/share/eclipse/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local root_markers = { 'gradlew', '.git', 'mvnw', 'pom' }

local config = {
    cmd = {
        '/usr/lib/jdtls/bin/jdtls',
        '/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/java',
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        '-configuration', '/usr/lib/jdtls/config_linux',
        '-jar', vim.fn.glob('/usr/lib/jdtls/plugins/org.eclipse.equinox.launcher_*.jar*'),
        '-data', workspace_dir
    },

    root_dir = require('jdtls.setup').find_root(root_markers),

    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = "/usr/lib/jvm/java-8-openjdk-amd64/"
                    },
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk-amd64/"
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
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
