{ config, ... }:

{
    sops = {
        age.keyFile = "/home/nixos/dotfiles/home/users/work-wsl/keys.txt";
        defaultSopsFile = ../../../secrets/kinsale.yaml;
        defaultSymlinkPath = "/run/user/1000/secrets";
        defaultSecretsMountPoint = "/run/user/1000/secrets.d";

        secrets = {
            NPM_PUBLISH_TOKEN.path = "${config.sops.defaultSymlinkPath}/NPM_PUBLISH_TOKEN";
            POSTGRES_DEV_HOST = {
                key = "DATABASE/POSTGRES/DEV/HOST";
                path = "${config.sops.defaultSymlinkPath}/POSTGRES_DEV_HOST";
            };
            POSTGRES_QA_HOST = {
                key = "DATABASE/POSTGRES/QA/HOST";
                path = "${config.sops.defaultSymlinkPath}/POSTGRES_QA_HOST";
            };
            POSTGRES_STAGE_HOST = {
                key = "DATABASE/POSTGRES/STAGE/HOST";
                path = "${config.sops.defaultSymlinkPath}/POSTGRES_STAGE_HOST";
            };
            POSTGRES_PROD_HOST = {
                key = "DATABASE/POSTGRES/PROD/HOST";
                path = "${config.sops.defaultSymlinkPath}/POSTGRES_PROD_HOST";
            };

            ORACLE_PASSWORD = {
                key = "DATABASE/PASSWORD";
                path = "${config.sops.defaultSymlinkPath}/ORACLE_PASSWORD";
            };
            ORACLE_USERNAME = {
                key = "DATABASE/USERNAME";
                path = "${config.sops.defaultSymlinkPath}/ORACLE_USERNAME";
            };

            POSTGRES_USERNAME = {
                key = "DATABASE/POSTGRES/USERNAME";
                path = "${config.sops.defaultSymlinkPath}/POSTGRES_USERNAME";
            };
            POSTGRES_PASSWORD = {
                key = "DATABASE/POSTGRES/PASSWORD";
                path = "${config.sops.defaultSymlinkPath}/POSTGRES_PASSWORD";
            };
        };
    };
}
