{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    maven
    jdk17
    temurin-bin-17
  ];

  AWS_PRPOFILE="nonprod";

  shellHook = ''
    # npm run docker:redis:up
    export db_username_dbktentcorr="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TMS.DATABASE.USERNAME' | tr -d '"')"
    export db_password_dbktentcorr="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TMS.DATABASE.PASSWORD' | tr -d '"')"
    export tenantid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')"

    export dev_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.DEV.CLIENT_ID' | tr -d '"')"
    export dev_client_secret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.DEV.CLIENT_SECRET' | tr -d '"')"
    export qa_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.QA.CLIENT_ID' | tr -d '"')"
    export qa_client_secret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.QA.CLIENT_SECRET' | tr -d '"')"
    export clientid=$dev_client_id
    export clientsecret=$dev_client_secret

    export automated_testing_dev_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_ID' | tr -d '"')"
    export automated_testing_dev_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_SECRET' | tr -d '"')"
    export automated_testing_qa_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_ID' | tr -d '"')"
    export automated_testing_qa_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_SECRET' | tr -d '"')"

    # forces the right profile if I'm logged into multiple
    export AWS_ACCESS_KEY_ID="$(sed -n '/\[nonprod\]/,/^\[/p' /home/nixos/.aws/credentials | rg aws_access_key_id | cut -d'=' -f2)"

    alias c="clear"
    trap 'clear' EXIT

    # gets a testing account token
    auth_dev() {
        export TOKEN=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$automated_testing_dev_client_id&scope=api://$dev_client_id/.default&client_secret=$automated_testing_dev_client_secret&grant_type=client_credentials" \
            "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" | jq -r '.access_token')
        echo $TOKEN
    }

    auth_qa() {
        export TOKEN=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$automated_testing_qa_client_id&scope=api://$qa_client_id/.default&client_secret=$automated_testing_qa_client_secret&grant_type=client_credentials" \
            "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" | jq -r '.access_token')
        echo $TOKEN
    }
  '';
}
