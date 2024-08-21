{ pkgs, ... }:

{
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
