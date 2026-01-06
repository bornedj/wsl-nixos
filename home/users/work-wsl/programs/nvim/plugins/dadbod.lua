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

vim.keymap.set("n", "<leader>db", "<cmd>silent DBUIToggle<CR>")
