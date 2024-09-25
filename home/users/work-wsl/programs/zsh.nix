{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        defaultKeymap = "vicmd";
        enableCompletion = true;
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "rust" "npm" "fzf" "mvn" "ng" "node" "ssh" ];
            theme = "cloud";
        };

        shellAliases = {
            c = "clear";
            cd = "z";
            cliphis = "history | fzf | cut -d ' ' -f 2- | clip.exe";
            p = "xclip -o";

            # alias to count all open inotify watchers
            watchercount = "lsof | rg inotify | wc -l";

            # cache cleans
            npmcc="npm cache clean -f";
            ngcc="ng cache clean";
            cc="npm cache clean -f && ng cache clean";

            gen_dms_jwt="docker run --rm --name jwt-cli bitnami/jwt-cli:latest encode -S b64:$JWT -P 'auth=[\"ROLE_ADMIN\"]' -s anonymous -A HS512 --no-typ -e=$(date -d '+1 days' +%s) | clip.exe";
            gen_doc="rm -rf docs/ && npm run doc";

            update = "cd ~/dotfiles && sudo nixos-rebuild switch --flake .#nixos";
        };

        profileExtra = ''
            eval "$(zoxide init zsh)"
        '';

        sessionVariables = {
            M2_HOME="~/.m2/";
            M2="$(which mvn)";
            PATH="$PATH:$M2:~/dotfiles/etc/nixos/pkgs/result/bin/ggshield";
            GATLING_HOME="/mnt/c/Users/daniel.borne/gatling/gatling-charts-highcharts-bundle-3.9.5";
            GATLING_RECORD=''$GATLING_HOME"/bin/recorder.sh"'';
            GATLING_GUI=''$GATLING_HOME"/bin/gatling.sh"'';
            JAVA_HOME="/etc/profiles/per-user/nixos/lib/openjdk";
        };
    };
}
