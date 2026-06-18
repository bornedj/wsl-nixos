{ config, ... }:

let 
    erdSchema = "dbktentref";
    corrSchema = "dbktentcorr";
in
{
    programs.dbeaver.enable = true;

    sops.templates."dbeaver-data-sources" = {
        path = "${config.xdg.dataHome}/DBeaverData/workspace6/General/.dbeaver/data-sources.json";
        content = builtins.toJSON {
            folders = { };
            connections = { 
                # postgres
                # erd dallas connections
                postgres-dev-erd = {
                    provider = "postgresql";
                    driver = "postgres-jdbc";
                    name = "Postgres Dev ERD";
                    save-password = true;
                    configuration = {
                        url = "jdbc:postgresql://${config.sops.placeholder.POSTGRES_DEV_HOST}${erdSchema}?user=${config.sops.placeholder.POSTGRES_USERNAME}&password=${config.sops.placeholder.POSTGRES_PASSWORD}";
                        configurationType = "URL";
                    };
                };
                postgres-qa-erd = {
                    provider = "postgresql";
                    driver = "postgres-jdbc";
                    name = "Postgres QA ERD";
                    save-password = true;
                    configuration = {
                        url = "jdbc:postgresql://${config.sops.placeholder.POSTGRES_QA_HOST}${erdSchema}?user=${config.sops.placeholder.POSTGRES_USERNAME}&password=${config.sops.placeholder.POSTGRES_PASSWORD}";
                        configurationType = "URL";
                    };
                };
                postgres-stage-erd = {
                    provider = "postgresql";
                    driver = "postgres-jdbc";
                    name = "Postgres Stage ERD";
                    save-password = true;
                    configuration = {
                        url = "jdbc:postgresql://${config.sops.placeholder.POSTGRES_STAGE_HOST}${erdSchema}?user=${config.sops.placeholder.POSTGRES_USERNAME}&password=${config.sops.placeholder.POSTGRES_PASSWORD}";
                        configurationType = "URL";
                    };
                };
                postgres-prod-erd = {
                    provider = "postgresql";
                    driver = "postgres-jdbc";
                    name = "Postgres PROD ERD";
                    save-password = true;
                    configuration = {
                        url = "jdbc:postgresql://${config.sops.placeholder.POSTGRES_PROD_HOST}${erdSchema}?user=${config.sops.placeholder.POSTGRES_USERNAME}&password=${config.sops.placeholder.POSTGRES_PASSWORD}";
                        configurationType = "URL";
                    };
                };

                # correspondence
                postgres-dev-corr = {
                    provider = "postgresql";
                    driver = "postgres-jdbc";
                    name = "Postgres Dev Correspondence";
                    save-password = true;
                    configuration = {
                        url = "jdbc:postgresql://${config.sops.placeholder.POSTGRES_DEV_HOST}${corrSchema}?user=${config.sops.placeholder.POSTGRES_USERNAME}&password=${config.sops.placeholder.POSTGRES_PASSWORD}";
                        configurationType = "URL";
                    };
                };
            };
        };
    };
}
