-- I need to find out if I can do this after boot with the env variables in my sops store
-- doing it this way for ease now
vim.g.dbs = {
    {
        name = "postgres-dev-corr",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.DEV.CORR_USER_PASS_URL")
    },
    {
        name = "postgres-qa-corr",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.QA.CORR_USER_PASS_URL")
    },
    {
        name = "postgres-stage-corr",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.STAGE.CORR_USER_PASS_URL")
    },
    {
        name = "postgres-prod-corr",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.POSTGRES.PROD.CORR_USER_PASS_URL")
    },
    {
        name = "ISBUM-dev",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.DEV.ISBUM_USER_PASS_URL")
    },
    {
        name = "ISBUM-qa",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.QA.ISBUM_USER_PASS_URL")
    },
    {
        name = "ISBUM-stage",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.STAGE.ISBUM_USER_PASS_URL")
    },
    {
        name = "ISBUM-prod",
        url = os.execute("sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq .DATABASE.PROD.ISBUM_USER_PASS_URL")
    },
}

vim.keymap.set("n", "<leader>db", "<cmd>silent DBUIToggle<CR>")
