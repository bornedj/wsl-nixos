{ pkgs, ... }:

{
    programs.home-manager.enable = true;
    home.stateVersion =  "24.11";
    home.username = "daniel";
    home.homeDirectory = "/home/daniel";
    home.packages = with pkgs; [
        #languages
        rustup
        python3
        nodejs
        lua

        # rust 
        zoxide
        ripgrep

        # CLI utils
        fzf
        curl
        age
        jq
        yq
        tree

        # oracle
        oracle-instantclient
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
            pull = {
                rebase = true;
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
