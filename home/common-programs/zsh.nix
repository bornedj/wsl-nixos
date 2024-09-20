{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        defaultKeymap = "vicmd";
        enableCompletion = true;
        oh-my-zsh = {
            enable = true;
            plugins = ["git"];
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

            home-wsl-update = "cd ~/config && sudo nixos-rebuild switch --flake .#home-wsl";
            work-wsl-update = "cd ~/config && sudo nixos-rebuild switch --flake .#nixos";
        };
    };
}
