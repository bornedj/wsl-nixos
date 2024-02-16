require('nvim-web-devicons').setup({
    color_icons = true,
    default = true,
    strict = true,
    override_by_filename = {
        [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
        }
    },
    -- same as `override` but specifically for overrides by extension
    --  takes effect when `strict` is true
    override_by_extension = {
        ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
        }
    },
})
