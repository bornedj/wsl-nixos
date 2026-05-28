{ pkgs, ... }:

let 
    vim-dadbod-ui-local = pkgs.callPackage ../../../../pkgs/vim-dadbod-local/vim-dadbod-ui.nix {};
in
{
    home.packages = with pkgs; [
        gcc
        clang-tools
    ];
    # home nvim configuration
    programs.neovim = {
        enable = true;
        withRuby = false;
        withPython3 = false;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;

        initLua = ''
            ${builtins.readFile ./set.lua}
            ${builtins.readFile ./remap.lua}
        '';

        extraPackages = with pkgs; [
            typescript-language-server
            bash-language-server
            vscode-langservers-extracted
            terraform-ls
            angular-language-server
            lua-language-server
            emmet-ls
            dockerfile-language-server
            yaml-language-server
            pyright
            nixd
            tree-sitter # cli doesn't ship with the grammars anymore
        ];

        plugins = with pkgs.vimPlugins; [
            plenary-nvim
            trouble-nvim
            vim-tmux-navigator
            nvim-jdtls
            nvim-dap
            markdown-preview-nvim
            nvim-cmp
            cmp-nvim-lsp
            nvim-web-devicons
            vim-dadbod
            # vim-dadbod-ui
            vim-dadbod-completion
            {
                plugin = vim-dadbod-ui-local;
                type = "lua";
                config = builtins.readFile ./plugins/dadbod.lua;
            }
            {
                plugin = claude-code-nvim;
                type = "lua";
                config = builtins.readFile ./plugins/claude-code.lua;
            }
            {
                plugin = vim-fugitive;
                type = "lua";
                config = builtins.readFile ./plugins/fugitive.lua;
            }
            {
                type = "lua";
                plugin = undotree;
                config = ''vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)'';
            }
            {
                # managing parsers itself, there's an open issue around doing it with nix
                type = "lua";
                plugin = nvim-treesitter.withAllGrammars;
                config = builtins.readFile ./plugins/treesitter.lua;
            }
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
                plugin = copilot-vim;
                config = builtins.readFile ./plugins/copilot.lua;
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
