{ pkgs, ... }:

{
    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
    home.packages = with pkgs; [
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
        gcc
        clang-tools
        ripgrep
        temurin-jre-bin
        age
        # attempting to enable first to ensure its set as default
        neovim
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
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
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
