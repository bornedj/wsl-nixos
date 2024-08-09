{ config, pkgs, ... }:

{
    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
    home.packages = with pkgs; [
        neovim
        git
        rustup
        python3
        nodejs
        lua
        tmux
        zoxide
        fzf
        stow
        curl
        # clang tools specifically needed for treesitter
        clang-tools
        ripgrep
        temurin-jre-bin
    ];
    home.stateVersion =  "24.05";

    programs.home-manager.enable = true;
    
    # git configuration
    programs.git = {
        enable = true;
    };
}
