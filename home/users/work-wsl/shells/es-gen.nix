{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {

  AWS_PRPOFILE="nonprod";
  SPRING_PROFILES_ACTIVE="dev";

  shellHook = ''
    export dev_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_GENERATION.DEV.CLIENT_ID' | tr -d '"')"
    export dev_client_secret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_GENERATION.DEV.CLIENT_SECRET' | tr -d '"')"
    export qa_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_GENERATION.QA.CLIENT_ID' | tr -d '"')"
    export qa_client_secret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_GENERATION.QA.CLIENT_SECRET' | tr -d '"')"
    export clientid=$dev_client_id
    export clientsecret=$dev_client_secret

    export dmsclientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS.CLIENT_SECRET' | tr -d '"')"
    export tenantid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')"

    export automated_testing_dev_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_ID' | tr -d '"')"
    export automated_testing_dev_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_SECRET' | tr -d '"')"
    export automated_testing_qa_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_ID' | tr -d '"')"
    export automated_testing_qa_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_SECRET' | tr -d '"')"

    trap 'clear' EXIT

    # gets a testing account token
    auth_qa() {
        export TOKEN=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$automated_testing_qa_client_id&scope=api://$qa_client_id/.default&client_secret=$automated_testing_qa_client_secret&grant_type=client_credentials" \
            "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" | jq -r '.access_token')
        echo $TOKEN
    }

    auth_dev() {
        export TOKEN=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$automated_testing_dev_client_id&scope=api://$dev_client_id/.default&client_secret=$automated_testing_dev_client_secret&grant_type=client_credentials" \
            "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" | jq -r '.access_token')
        echo $TOKEN
    }
  '';
}
