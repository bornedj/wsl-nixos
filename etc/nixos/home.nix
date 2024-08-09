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
        clang-tools
        gcc
        cmake
        ripgrep
    ];
    home.stateVersion =  "24.05";

    programs.home-manager.enable = true;
}
