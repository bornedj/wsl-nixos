return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
        "BufReadPre /home/daniel/obsidian/**.md",
        "BufNewFile /home/daniel/obsidian/**.md",
    },
    -- ft = "markdown",
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/obsidian/personal",
            },
            {
                name = "architecture",
                path = "~/obsidian/architecture",
            }
        },
        daily_notes = {
            folder = "daily"
        },
    },
}
