require("obsidian").setup {
    workspaces = {
        {
            name = "personal",
            path = "~/obsidian/personal",
        },
        {
            name = "architecture",
            path = "~/obsidian/architecture",
        },
        {
            name = "daily_notes",
            path = "~/obsidian/daily",
        }
    },
    daily_notes = {
        folder = "daily"
    },
}
