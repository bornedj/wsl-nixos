{
  pkgs,
}:

pkgs.vimUtils.buildVimPlugin {
    name = "vim-dadbod-ui";
    src = pkgs.fetchFromGitHub {
        owner = "bornedj";
        repo = "vim-dadbod-ui";
        rev = "fix/oracle-table-name-truncation-237";
        hash = "sha256-BLlmegQmBDY42vefhwR6xNpf1Ot0yaQ2ulwsu4UlE1Q=";
    };
}

