{ pkgs, inputs, ... }:

{
    imports = [
        ../../common-programs/tmux
        ./programs/zsh.nix
        ./programs/nvim
        inputs.sops-nix.homeManagerModules.sops
    ];

    programs.home-manager.enable = true;
    home.stateVersion =  "24.11";
    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
    home.packages = with pkgs; [
        # languages 
        rustup
        python3
        nodejs
        lua
        jdk
        maven

        # rust cli
        zoxide
        ripgrep

        # cli utils
        fzf
        curl
        age
        jq
        yq
        tree
        bruno
        deck
        kubectl
        aws-azure-login

        # java utils
        jdt-language-server

        # commit lint
        ggshield
        nodePackages.prettier

        # oracle
        oracle-instantclient

        # secrets
        sops

        # claude
        claude-code
    ];
    
    # home git configuration
    programs.git = {
        enable = true;
        userName = "Daniel Borne";
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
        ignores = [
            "shell.nix"
        ];
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

    # github cli configuration
    programs.gh = {
        enable = true;
        settings = {
            editor = "nvim";
        };
    };
}
