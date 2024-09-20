{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        defaultKeymap = "vicmd";
        enableCompletion = true;
    };
}
