{ ... }:

let 
    gitlabPath = "/home/nixos/gitlab_linux/";
in
{
    home.file."${gitlabPath}document-management-service/shell.nix" = {
        source = ./dms.nix;
        force = true;
    };
}
