require("obsidian").setup {
    legacy_commands = false,
    workspaces = {
        {
            name = "personal",
            path = "~/obsidian/personal",
        },
        {
            name = "ess",
            path = "~/obsidian/ess",
        },
        {
            name = "architecture",
            path = "~/obsidian/architecture",
        },
        {
            name = "daily_notes",
            path = "~/obsidian/daily",
        },
        {
            name = "KIT",
            path = "~/obsidian/KIT",
        },
    },
    daily_notes = {
        folder = "daily"
    },
}
