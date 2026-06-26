{ ... }:

let 
    gitlabPath = "/home/nixos/gitlab_linux/";
in
{
    home.file."${gitlabPath}document-management-service/shell.nix" = {
        source = ./dms.nix;
        force = true;
    };
    home.file."${gitlabPath}document-and-note-coexistence-service/shell.nix" = {
        source = ./danms-coexistence.nix;
        force = true;
    };
    home.file."${gitlabPath}document-management-mfe/shell.nix" = {
        source = ./danms-mfe.nix;
        force = true;
    };
    home.file."${gitlabPath}document-management-shell/shell.nix" = {
        source = ./danms-shell.nix;
        force = true;
    };
    home.file."${gitlabPath}dallas-enterprise-ref-api/shell.nix" = {
        source = ./erd-dallas.nix;
        force = true;
    };
    home.file."${gitlabPath}enterprise-solutions-distribution-service/shell.nix" = {
        source = ./es-distro.nix;
        force = true;
    };
    home.file."${gitlabPath}enterprise-solutions-document-generation-service/shell.nix" = {
        source = ./es-gen.nix;
        force = true;
    };
    home.file."${gitlabPath}enterprise-solutions-template-management-service/shell.nix" = {
        source = ./es-gen.nix;
        force = true;
    };
    home.file."${gitlabPath}kinsale-material/shell.nix" = {
        source = ./material.nix;
        force = true;
    };
    home.file."${gitlabPath}notes-management-service/shell.nix" = {
        source = ./nms.nix;
        force = true;
    };
    home.file."${gitlabPath}personal-insurance-service/shell.nix" = {
        source = ./pins.nix;
        force = true;
    };
    home.file."${gitlabPath}aspera-pi-portal/shell.nix" = {
        source = ./pip.nix;
        force = true;
    };
    home.file."${gitlabPath}PIP/shell.nix" = {
        source = ./pip-test.nix;
        force = true;
    };
    home.file."${gitlabPath}transit-policy-service/shell.nix" = {
        source = ./tps.nix;
        force = true;
    };
    home.file."${gitlabPath}target-state-file-cabinet/shell.nix" = {
        source = ./ts-file-cabinet.nix;
        force = true;
    };
    home.file."${gitlabPath}transit-uw-worksheets-service/shell.nix" = {
        source = ./tuw-ms.nix;
        force = true;
    };
    home.file."${gitlabPath}transit-uw-worksheets/shell.nix" = {
        source = ./tuw-ui.nix;
        force = true;
    };
}
