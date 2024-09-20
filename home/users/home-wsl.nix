{ pkgs, inputs, ... }:

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

    programs.home-manager.enable = true;
    home.stateVersion =  "24.05";
    home.username = "daniel";
    home.homeDirectory = "/home/daniel";
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
        age
        jq
        yq
        tree
    ];

    
    # home git configuration
    programs.git = {
        enable = true;
        userName = "bornedj";
        userEmail = "borne.danielj@gmail.com";
        extraConfig = {
            core = {
                symlinks = false;
            };
        };
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
    imports = [
        ../common-programs/nvim
        ../common-programs/tmux
        ../common-programs/zsh.nix
    ];
}
