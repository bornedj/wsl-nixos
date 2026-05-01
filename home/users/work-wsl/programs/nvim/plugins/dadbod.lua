-- I need to find out if I can do this after boot with the env variables in my sops store
-- doing it this way for ease now
vim.g.dbs = {
    {
        name = "postgres-dev-corr",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.DEV.CORR_USER_PASS_URL | tr -d '\"\n'")
    },
    {
        name = "postgres-qa-corr",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.QA.CORR_USER_PASS_URL | tr -d '\"\n'")
    },
    {
        name = "postgres-stage-corr",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.STAGE.CORR_USER_PASS_URL | tr -d '\"\n'")
    },
    {
        name = "postgres-prod-corr",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.PROD.CORR_USER_PASS_URL | tr -d '\"\n'")
    },
    {
        name = "ISBUM-dev",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.DEV.ISUBM_USER_PASS_URL | tr -d '\"\n'")
    },
    {
        name = "ISBUM-qa",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.QA.ISUBM_USER_PASS_URL | tr -d '\"\n'")
    },
    {
        name = "ISBUM-stage",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.STAGE.ISUBM_USER_PASS_URL | tr -d '\"\n'")
    },
    {
        name = "ISBUM-prod",
        url = vim.fn.system("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.PROD.ISUBM_USER_PASS_URL | tr -d '\"\n'")
    },
}
vim.g.db_ui_winwidth = 50
vim.g.db_ui_trim = 40

vim.keymap.set("n", "<leader>db", "<cmd>silent DBUIToggle<CR>")

-- Override dadbod-ui keymappings with vim-tmux-navigator
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dbui",
    callback = function()
        vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { buffer = true })
        vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { buffer = true })
    end,
})

-- add row limit to the oracle list helper
vim.g.db_ui_table_helpers = {
    oracle = {
        List = string.gsub([[
SET linesize 4000;
SET pagesize 4000;

COLUMN column_name FORMAT a~;
COLUMN constraint_type FORMAT a~;
COLUMN index_name FORMAT a~;
COLUMN owner FORMAT a~;
COLUMN table_name FORMAT a~;

SELECT * FROM "{dbname}"."{table}"
WHERE ROWNUM <=200
;
        ]], "~", vim.g.db_ui_trim)
    }
}

-- disable folding
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dbout",
    callback = function()
        vim.wo.foldenable = false
        vim.wo.wrap = false
    end,
})
