return {
    'rmehri01/onenord.nvim',
    name = 'onenord',
    lazy = false,
    opts = {
      disable = {
        background = true, -- Disable setting the background color
        cursorline = true, -- Disable the cursorline
        eob_lines = true, -- Hide the end-of-buffer lines
      },
    },
    config = function ()
        vim.cmd.colorscheme("onenord")

        vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
        vim.api.nvim_set_hl(0, "CocInlayHint", {bg = "none"})
        vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg= "none"})
        vim.api.nvim_set_hl(0, 'TelescopeBackground', {bg= "none"})
        vim.api.nvim_set_hl(0, 'NormalFloat', {bg= "none"})
        vim.api.nvim_set_hl(0, 'FloatBorder', {bg= "none"})
        vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultError', {bg= "none"})
        vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultWarning', {bg= "none"})
        vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultInformation', {bg= "none"})
        vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultHint', {bg= "none"})
        vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineWarning', {bg= "none"})
        vim.api.nvim_set_hl(0, 'Normal', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Comment', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Identifier', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Special', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Constant', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Underlined', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Todo', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Statement', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'String', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Function', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'PreProc', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Type', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Operator', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Repeat', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Conditional', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'LineNr', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'Structure', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'CursorLine', { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'SignColumn', { bg = "NONE", ctermbg = "NONE" })
    end
}
