local function read_secret(path)
    local f = io.open(path, "r")
    if not f then return "" end
    local val = f:read("*l")
    f:close()
    return val or ""
end

local pg_user = read_secret(secret.postgresUsername):gsub("@", "%%40")
local pg_pass = read_secret(secret.postgresPassword)
local ora_user = read_secret(secret.oracleUsername)
local ora_pass = read_secret(secret.oraclePassword)

local pg_dev = read_secret(secret.postgresDevHost)
local pg_qa = read_secret(secret.postgresQaHost)
local pg_stage = read_secret(secret.postgresStageHost)
local pg_prod = read_secret(secret.postgresProdHost)

local function pg_url(host, db)
    return "postgresql://" .. pg_user .. ":" .. pg_pass .. "@" .. host .. db
end

local function ora_url(host)
    return "oracle:" .. ora_user .. "/" .. ora_pass .. "@//" .. host
end

vim.g.dbs = {
    { name = "postgres-dev-erd", url = pg_url(pg_dev, "dbktentref") },
    { name = "postgres-qa-erd", url = pg_url(pg_qa, "dbktentref") },
    { name = "postgres-stage-erd", url = pg_url(pg_stage, "dbktentref") },
    { name = "postgres-prod-erd", url = pg_url(pg_prod, "dbktentref") },
    { name = "postgres-dev-corr", url = pg_url(pg_dev, "dbktentcorr") },
    { name = "postgres-qa-corr", url = pg_url(pg_qa, "dbktentcorr") },
    { name = "postgres-stage-corr", url = pg_url(pg_stage, "dbktentcorr") },
    { name = "postgres-prod-corr", url = pg_url(pg_prod, "dbktentcorr") },
    { name = "ISUBM-dev", url = ora_url(read_secret(secret.isubmDevHost)) },
    { name = "ISUBM-qa", url = ora_url(read_secret(secret.isubmQaHost)) },
    { name = "ISUBM-stage", url = ora_url(read_secret(secret.isubmStageHost)) },
    { name = "ISUBM-prod", url = ora_url(read_secret(secret.isubmProdHost)) },
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
SET linesize 32000;
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
