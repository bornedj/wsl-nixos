{ pkgs, inputs, ... }:

let 
    ggshieldOverrides = import pkgs/ggshield;
in
{
    nixpkgs = {
        overlays = [
            (final: prev: {
                vimPlugins = prev.vimPlugins // {
                    own-fugitive = prev.vimUtils.buildVimPlugin {
                        name = "fugitive";
                        src = inputs.plugins-fugitive;
                    };

                    own-nvim-web-devicons = prev.vimUtils.buildVimPlugin {
                        name = "nvim-web-devicons";
                        src = inputs.plugins-nvim-web-devicons;
                    };
                };
            })
        ];
    };

    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
    home.packages = with pkgs; [
        git
        # rust 
        rustup
        zoxide
        ripgrep
        python3
        nodejs
        lua
        fzf
        stow
        curl
        # clang tools specifically needed for treesitter
        gcc
        clang-tools
        age
        # java
        jdt-language-server
        jdk
        maven
        jq
        yq
        tree
        ggshieldOverrides.ggshield
    ];
    home.stateVersion =  "24.05";

    programs.home-manager.enable = true;
    
    # home git configuration
    programs.git = {
        enable = true;
        userName = "daniel.borne";
        userEmail = "daniel.borne@kinsaleins.com";
        extraConfig = {
            core = {
                symlinks = false;
            };
        };
    };

    # home nvim configuration
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;

        extraLuaConfig = ''
            ${builtins.readFile ./programs/nvim/set.lua}
            ${builtins.readFile ./programs/nvim/remap.lua}
        '';

        extraPackages = with pkgs; [
            nodePackages.typescript-language-server
            rust-analyzer
            nil
        ];

        plugins = with pkgs.vimPlugins; [
            {
                # managing parsers itself, there's an open issue around doing it with nix
                type = "lua";
                plugin = nvim-treesitter;
                config = builtins.readFile ./programs/nvim/plugins/treesitter.lua;
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
            nvim-lspconfig
            mason-nvim
            mason-lspconfig-nvim
            {
                type = "lua";
                plugin = onenord-nvim;
                config = builtins.readFile ./programs/nvim/plugins/colors.lua;
            }
            {
                type = "lua";
                plugin = comment-nvim;
                config = builtins.readFile ./programs/nvim/plugins/comment.lua;
            }
            {
                type = "lua";
                plugin = copilot-vim;
                config = builtins.readFile ./programs/nvim/plugins/copilot.lua;
            }
            {
                type = "lua";
                plugin = fugitive;
                config = builtins.readFile ./programs/nvim/plugins/fugitive.lua;
            }
            {
                type = "lua";
                plugin = harpoon;
                config = builtins.readFile ./programs/nvim/plugins/harpoon.lua;
            }
            # TODO: look into replacing lsp zero and install language servers myself
            {
                type = "lua";
                plugin = lsp-zero-nvim;
                config = builtins.readFile ./programs/nvim/plugins/lsp.lua;
            }
            {
                type = "lua";
                plugin = obsidian-nvim;
                config = builtins.readFile ./programs/nvim/plugins/obsidian.lua;
            }
            {
                type = "lua";
                plugin = telescope-nvim;
                config = builtins.readFile ./programs/nvim/plugins/telescope.lua;
            }
            {
                type = "lua";
                plugin = trouble-nvim;
                config = builtins.readFile ./programs/nvim/plugins/trouble.lua;
            }
            {
                type = "lua";
                plugin = nvim-web-devicons;
                config = builtins.readFile ./programs/nvim/plugins/web-devicons.lua;
            }
            {
                type = "lua";
                plugin = which-key-nvim;
                config = builtins.readFile ./programs/nvim/plugins/which-key.lua;
            }
        ];
    };

    programs.tmux = {
        enable = true;
        escapeTime = 300;
        prefix = "C-a";
        keyMode = "vi";
        mouse = true;
        clock24 = true;

        plugins = with pkgs.tmuxPlugins; [
            vim-tmux-navigator
            resurrect
            continuum
            nord
        ];

        extraConfig = ''
            ${builtins.readFile ./programs/tmux/tmux.conf}
        '';
    };

    # browser configuration
    programs.firefox = {
        enable = true;
    };

    # sops configuration
    # sops = {
    #     age.keyFile = "/home/nixos/dotfiles/etc/nixos/sops/age/key.txt";
    #     defaultSopsFile = ./secrets.json;
    #     secrets.test = {
    #         path = "%r/test.text";
    #     };
    # };
}
