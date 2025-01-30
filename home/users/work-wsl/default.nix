{ pkgs, inputs, ... }:

let 
    ggshieldOverrides = import ../../pkgs/ggshield;
    jhipsterOverrides = import ../../pkgs/jhipster;
in
{
    imports = [
        ../../common-programs/tmux
        ./programs/zsh.nix
        ./programs/nvim
        inputs.sops-nix.homeManagerModules.sops
    ];

    programs.home-manager.enable = true;
    home.stateVersion =  "24.05";
    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
    home.packages = with pkgs; [
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
        jhipsterOverrides.jhipster
        bruno
        deck
        kubectl
        sops
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
            pull = {
                rebase = true;
            };
            push = {
                autoSetupRemote = "true";
            };
        };
    };

    # browser configuration
    programs.firefox = {
        enable = true;
    };

    # sops configuration
    sops = {
        age.keyFile = "/home/nixos/dotfiles/home/users/work-wsl/keys.txt";
        defaultSopsFile = ../../secrets/kinsale.yaml;
    };
}
