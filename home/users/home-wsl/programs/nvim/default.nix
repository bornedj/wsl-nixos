{ pkgs, inputs, ... }:

{
    home.packages = with pkgs; [
        gcc
        clang-tools
    ];
    # home nvim configuration
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;

        extraLuaConfig = ''
            ${builtins.readFile ./set.lua}
            ${builtins.readFile ./remap.lua}
        '';

        extraPackages = with pkgs; [
            nodePackages.typescript-language-server
            nodePackages.vscode-langservers-extracted
            nodePackages.bash-language-server
            nil
            lua-language-server
            emmet-ls
            dockerfile-language-server-nodejs
            yaml-language-server
            pyright
            inputs.plugins-angularls
        ];

        plugins = with pkgs.vimPlugins; [
            {
                # managing parsers itself, there's an open issue around doing it with nix
                type = "lua";
                plugin = nvim-treesitter;
                config = builtins.readFile ./plugins/treesitter.lua;
            }
            plenary-nvim
            trouble-nvim
            {
                type = "lua";
                plugin = undotree;
                config = ''vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)'';
            }
            vim-tmux-navigator
            nvim-jdtls
            nvim-dap
            markdown-preview-nvim
            nvim-cmp
            cmp-nvim-lsp
            {
                type = "lua";
                plugin = nvim-lspconfig;
                config = builtins.readFile ./plugins/lsp.lua;
            }
            {
                type = "lua";
                plugin = onenord-nvim;
                config = builtins.readFile ./plugins/colors.lua;
            }
            {
                type = "lua";
                plugin = comment-nvim;
                config = builtins.readFile ./plugins/comment.lua;
            }
            {
                type = "lua";
                plugin = fugitive;
                config = builtins.readFile ./plugins/fugitive.lua;
            }
            {
                type = "lua";
                plugin = harpoon;
                config = builtins.readFile ./plugins/harpoon.lua;
            }
            {
                type = "lua";
                plugin = obsidian-nvim;
                config = builtins.readFile ./plugins/obsidian.lua;
            }
            {
                type = "lua";
                plugin = telescope-nvim;
                config = builtins.readFile ./plugins/telescope.lua;
            }
            {
                type = "lua";
                plugin = trouble-nvim;
                config = builtins.readFile ./plugins/trouble.lua;
            }
            {
                type = "lua";
                plugin = nvim-web-devicons;
                config = builtins.readFile ./plugins/web-devicons.lua;
            }
            {
                type = "lua";
                plugin = which-key-nvim;
                config = builtins.readFile ./plugins/which-key.lua;
            }
        ];
    };
}
