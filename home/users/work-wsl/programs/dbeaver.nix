{ config, ... }:

{
    programs.dbeaver.enable = true;

    sops.templates."dbeaver-data-sources" = {
        path = "${config.xdg.dataHome}/DBeaverData/workspace6/General/.dbeaver/data-sources.json";
        content = builtins.toJSON {
            folders = { };
            connections = {
                postgres-dev-erd = {
                    provider = "postgresql";
                    driver = "postgres-jdbc";
                    name = "Postgres Dev ERD";
                    save-password = true;
                    configuration = {
                        url = config.sops.placeholder.POSTGRES_DEV_JDBC_ERD_URL;
                        configurationType = "URL";
                    };
                };
            };
        };
    };
}
