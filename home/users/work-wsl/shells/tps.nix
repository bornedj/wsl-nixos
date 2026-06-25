{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  AWS_PRPOFILE="nonprod";
  SPRING_PROFILES_ACTIVE="local,no-liquibase";
  XRAY_URL="https://xray.cloud.getxray.app";
  XRAY_TESTPLANKEY="foo";
  xray_testPlanKey="foo";
  test_env="qa";
  cloudApiBaseUrl="https://xray.cloud.getxray.app";
  # XRAY_PROJECT="ESS";
  ENVIRONMENT="dev";

  shellHook = ''
    export db_username_dbktpolicy="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TPS.DATABASE.USERNAME' | tr -d '"')"
    export db_password_dbktpolicy="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TPS.DATABASE.PASSWORD' | tr -d '"')"

    export dev_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TPS.DEV.CLIENT_ID' | tr -d '"')"
    export dev_clientsecret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TPS.DEV.CLIENT_SECRET' | tr -d '"')"
    export qa_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TPS.QA.CLIENT_ID' | tr -d '"')"
    export qa_clientsecret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TPS.QA.CLIENT_SECRET' | tr -d '"')"
    export clientid=$dev_clientid
    export clientsecret=$dev_clientsecret

    export automated_testing_dev_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_ID' | tr -d '"')"
    export automated_testing_dev_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_SECRET' | tr -d '"')"
    export automated_testing_qa_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_ID' | tr -d '"')"
    export automated_testing_qa_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_SECRET' | tr -d '"')"

    export tenantid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')"
    export XRAY_CLIENTID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.XRAY.CLIENT_ID' | tr -d '"')"
    export XRAY_CLIENTSECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.XRAY.CLIENT_SECRET' | tr -d '"')"

    # gets a testing account token
    auth_qa() {
        export TOKEN=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$automated_testing_qa_client_id&scope=api://$qa_clientid/.default&client_secret=$automated_testing_qa_client_secret&grant_type=client_credentials" \
            "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" | jq -r '.access_token')
        echo $TOKEN
    }

    auth_dev() {
        export TOKEN=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$automated_testing_dev_client_id&scope=api://$clientid/.default&client_secret=$automated_testing_dev_client_secret&grant_type=client_credentials" \
            "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" | jq -r '.access_token')
        echo $TOKEN
    }

    trap 'clear' EXIT
  '';
}
