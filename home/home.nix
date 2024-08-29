{ pkgs, inputs, allowed-unfree-packages, ... }:

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
                        src = inputs.plugin-fugitive;
                    };

                    own-nvim-web-devicons = prev.vimUtils.buildVimPlugin {
                        name = "nvim-web-devicons";
                        src = inputs.plugin-nvim-web-devicons;
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
        tmux
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
    programs.neovim = let 
        toLua = str:  "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
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

        plugins = with pkgs.vimPlugins; [
            plenary-nvim
            trouble-nvim
            {
                plugin = undotree;
                config = toLua ''vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)'';
            }
            vim-tmux-navigator
            nvim-jdtls
            nvim-dap
            markdown-preview-nvim
            nvim-cmp
            {
                plugin = onenord-nvim;
                config = toLuaFile ./programs/nvim/plugins/colors.lua;
            }
            {
                plugin = comment-nvim;
                config = toLuaFile ./programs/nvim/plugins/comment.lua;
            }
            # commenting out until I figure out how to build it without a free license
            # {
            #     plugin = copilot-vim;
            #     config = toLuaFile ./programs/nvim/plugins/copilot.lua;
            # }
            {
                plugin = fugitive;
                config = toLuaFile ./programs/nvim/plugins/fugitive.lua;
            }
            {
                plugin = harpoon;
                config = toLuaFile ./programs/nvim/plugins/harpoon.lua;
            }
            # TODO: look into replacing lsp zero and install language servers myself
            # {
            #     plugin = lsp-zero-nvim;
            #     config = toLuaFile ./programs/nvim/plugins/lsp.lua;
            # }
            {
                plugin = obsidian-nvim;
                config = toLuaFile ./programs/nvim/plugins/obsidian.lua;
            }
            {
                plugin = telescope-nvim;
                config = toLuaFile ./programs/nvim/plugins/telescope.lua;
            }
            {
                plugin = trouble-nvim;
                config = toLuaFile ./programs/nvim/plugins/trouble.lua;
            }
            {
                plugin = nvim-web-devicons;
                config = toLuaFile ./programs/nvim/plugins/web-devicons.lua;
            }
            {
                plugin = which-key-nvim;
                config = toLuaFile ./programs/nvim/plugins/which-key.lua;
            }
        ];
    };

    # home.file."./.config/nvim/" = {
    #     source = ./programs/nvim;
    #     recursive = true;
    # };

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
