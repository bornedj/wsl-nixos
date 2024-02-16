vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pV", "<cmd> Sex! <CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<M-x>", "<C-x>")

vim.keymap.set("n", "J", "mzj`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set('x', '<leader>p', "\"_dp")

-- clipboard
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"*y")
vim.keymap.set('v', '<leader>Y', "\"*y")

vim.keymap.set("n", "Q", "<nop>")

--tmux stuff
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/tmux-sessionizer.sh<CR>")
vim.keymap.set("n", "<leader>f", function()
    -- vim.lsp.buf.format({formatting_options = {tabSize = 4}})
    vim.lsp.buf.format({formatting_options = {tabSize = 2}})
end)

vim.keymap.set("v", "<leader>f", function()
    -- vim.lsp.buf.format({formatting_options = {tabSize = 4}})
    vim.lsp.buf.format({formatting_options = {tabSize = 2}})
end)

-- vim.keymap.set("n", "<a-j>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<a-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]r", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[r", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- command to open a file explorer in the location of the current buffer
vim.keymap.set("n", "<leader>fe", function()
    local startingDir = vim.fn.getcwd()
    vim.cmd("cd %:h")
    vim.cmd("silent !explorer.exe .")
    vim.cmd(string.format("cd %s", startingDir))
end)

-- open windows git bash and cd into the dir of the current buffer
vim.keymap.set("n", "<leader>gb", function()
    vim.cmd(string.format("silent !/mnt/c/Program\\ Files/Git/git-bash.exe --cd=%s", vim.fn.getcwd()))
end)

-- another wsl specific bind, used to remove ^M from files 
-- that have had windows carriages added to files
vim.keymap.set("n", "<leader>ux", function()
    vim.cmd("update")
    vim.cmd("e ++ff=dos")
    vim.cmd("setlocal ff=unix")
    vim.cmd("w")
end)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- line number toggles
vim.keymap.set("n", "<leader>ln", function()
    vim.cmd("set number")
    vim.cmd("set rnu!")
end)

-- copy the file name to the unamed register
vim.keymap.set("n", "<leader>cfn", '<cmd>silent let @" = expand("%:t")<CR>')

-- copy current buffer file path to the system clipboard
vim.keymap.set("n", "<leader>cfp", '<cmd>silent let @+ = expand("%:p")<CR>')

-- copy current buffer file path to the system clipboard
vim.keymap.set("n", "<leader>cfrp", '<cmd>silent let @+ = expand("%")<CR>')
