{ pkgs, ... }: 

{
    programs.tmux = {
        enable = true;
        escapeTime = 300;
        prefix = "C-a";
        keyMode = "vi";
        mouse = true;
        clock24 = true;

        plugins = with pkgs.tmuxPlugins; [
            vim-tmux-navigator
            resurrect
            continuum
            nord
        ];

        extraConfig = ''
            ${builtins.readFile ./tmux.conf}
        '';
    };
}
