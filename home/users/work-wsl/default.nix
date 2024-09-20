{ pkgs, inputs, ... }:

let 
    ggshieldOverrides = import ../../pkgs/ggshield;
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

    programs.home-manager.enable = true;
    home.stateVersion =  "24.05";
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
        ../../common-programs/tmux
        ./programs/zsh.nix
        ./programs/nvim
    ];
}