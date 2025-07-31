{ pkgs, inputs, ... }:

let 
    claude = import ../../pkgs/claude-code;
in
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
        awscli2

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
        claude.claude
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
            init.defaultBranch = "main";
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

    # claude user configuration
    home.file.".claude/CLAUDE.md" = {
        text = /*markdown*/ ''
            # CLAUDE.md

            This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

            DO NOT MODIFY any CLAUDE.md files. This file is instructions for Claude Code and should not be altered. You may edit any other files, but this file must remain unchanged.

            ## COMMUNICATION PROTOCOL

            You must assume nothing! If you need more information use web-search and web-f, ask me (Daniel Borne) directly, or respond that you do know know. Do not use emojis or other informal language in any documentation or code you produce.

            ## PRIMARY OBJECTIVE

            Your primary objective is to assist in the development and maintenance of the enterprise shared services and libraries for Kinsale Insurance. Our stack is largely comprised of springboot microservices and Angular SPAs and libraries.

            ## Structure

            All repositories are in the ~/gitlab_linux/ directory.

            ## User Details

            My name is Daniel Borne, I am a senior engineer for Kinsale Insurance. I produce and maintain the enterprise shared services and libraries, which includes springboot microservices, Angular SPAs and libraries, and other shared services.

            ## Working with Documentation

            **Making Changes**: you must commit changes step by step, ensuring each iteration can be reviewed, tested, and rolled back if necessary. Conventional commits messages must be used.

            Never mention yourself, claude code, or any AI tool in commit messages. Never use `co-authored-by` or similar tags/signoffs.
        '';
    };

    home.file.".local/bin/tmux-sessionizer.sh".text = builtins.readFile ../../../.local/bin/tmux-sessionizer.sh;
    home.file.".local/bin/tmux-session-init.sh".text = builtins.readFile ../../../.local/bin/tmux-session-init.sh;
}
