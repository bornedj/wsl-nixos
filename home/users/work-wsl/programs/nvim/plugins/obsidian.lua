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
    },
    daily_notes = {
        folder = "daily"
    },
}
