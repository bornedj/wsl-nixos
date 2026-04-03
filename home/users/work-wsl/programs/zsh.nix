{ config, ... }:

{
    programs.zsh = {
        enable = true;
        defaultKeymap = "vicmd";
        enableCompletion = true;
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "rust" "npm" "fzf" "mvn" "ng" "node" "ssh" "docker" "docker-compose" "kubectl"];
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

            # eclipse clean
            ec="mvn clean eclipse:clean eclipse:eclipse";

            gen_dms_jwt="docker run --rm --name jwt-cli bitnami/jwt-cli:latest encode -S b64:$JWT -P 'auth=[\"ROLE_ADMIN\"]' -s anonymous -A HS512 --no-typ -e=$(date -d '+1 days' +%s) | clip.exe";
            gen_doc="rm -rf public/ && npm run doc";

            # impure as I'm using an abosulte path to my cert file
            # need to research how I can add copy this file to the nix store so that I can use a relative path
            update = "cd ~/dotfiles && sudo nixos-rebuild switch --flake .#nixos --impure";

            fix_forms="rm -rf node_modules/@kinsale/forms && cc && npm i ../kinsale-forms/dist/kinsale-forms/kinsale-forms-17.21.0.tgz --force && npx ng serve -c local";

            delete_node_modules="cd ~/gitlab_linux && find -maxdepth 2 -type d | rg node_modules | xargs rm -rf";

            vpn_kit="sudo systemctl start wsl-vpnkit.service";
            vpn_kit_off="sudo systemctl stop wsl-vpnkit.service";
        };

        profileExtra = ''
            # ignore dist directories
            export _ZO_EXCLUDE_DIRS="dist/*"
        '';

        initContent = ''
            extract_secret() {
                sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq $1 | tr -d '"' | clip.exe
            }
            eval "$(zoxide init zsh)"
            # remove windows nodejs
            export PATH="''${PATH//\/mnt\/c\/Program Files\/nodejs/}"
            export PATH="''${PATH//\/mnt\/c\/Users\/daniel.borne\/AppData\/Roaming\/npm/}"
            NPM_PUBLISH_TOKEN="$(cat ${config.sops.secrets.NPM_PUBLISH_TOKEN.path})";
        '';

        sessionVariables = {
            M2_HOME="~/.m2/";
            M2="$(which mvn)";
            PATH="$M2:~/.npm/bin:$PATH";
            NODE_PATH="~/.npm/bin";
            GATLING_HOME="/mnt/c/Users/daniel.borne/gatling/gatling-charts-highcharts-bundle-3.9.5";
            GATLING_RECORD=''$GATLING_HOME"/bin/recorder.sh"'';
            GATLING_GUI=''$GATLING_HOME"/bin/gatling.sh"'';
            JAVA_HOME="/etc/profiles/per-user/nixos/lib/openjdk";
            FILECABINET_PATH="\\kv-lin-img-u01\filecabinet\submission\000000001";
            JAVAX_NET_SSL_TRUSTSTORE = "etc/ssl/certs/ca-certificates.crt";
        };
    };
}
