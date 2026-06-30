{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  AWS_PROFILE="nonprod";
  SPRING_PROFILES_ACTIVE="local";

  shellHook = ''
    # npm run docker:redis:up
    export dms_legacy_db_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.LEGACY.USERNAME' | tr -d '"')"
    export dms_legacy_db_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.LEGACY.PASSWORD' | tr -d '"')"
    export dms_db_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.TARGET_STATE.USERNAME')"
    export dms_db_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.TARGET_STATE.PASSWORD')"
    export smb_sa_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.SMB.PASSWORD' | tr -d '"')"
    export smb_sa_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.SMB.USERNAME' | tr -d '"')"
    export tenantid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')"

    export AWS_REGION="us-east-1";
    export db_url=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.DEV.ISUBM_URL' | tr -d '"')
    export DBUI_URL="oracle:$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.DEV.ISUBM_URL' | tr -d '"')" # vim dadbod specific

    # rest assured env var setup
    export DMS_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS.DEV.CLIENT_ID' | tr -d '"')"
    export automated_testing_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_ID' | tr -d '"')"
    export automated_testing_client_secret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_SECRET' | tr -d '"')"
    export DOCUMENT_MANAGEMENT_SERVICE_AZURE_TOKEN=$(curl -s -X POST \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -d "client_id=$automated_testing_client_id&scope=api://$DMS_CLIENT_ID/.default&client_secret=$automated_testing_client_secret&grant_type=client_credentials" \
      "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" \
      | jq -r '.access_token')
    export DBKTDOCMGMT_CREDENTIALS_USERNAME="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DATABASE.DBKTDOCMGMT.USERNAME' | tr -d '"')"
    export DBKTDOCMGMT_CREDENTIALS_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DATABASE.DBKTDOCMGMT.PASSWORD' | tr -d '"')"

    # xray setup
    export XRAY_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.XRAY.CLIENT_ID' | tr -d '"')"
    export XRAY_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.XRAY.CLIENT_SECRET' | tr -d '"')"

    alias rm_s3_dev="aws s3 rm s3://transit-file-cabinet-scanned-us-east-1-dev/submission/99999999/ --recursive"
    alias dms_run_dev="mvn -Dspring.datasource.secondary.username=$dms_legacy_db_username -Dspring.datasource.secondary.password=$dms_legacy_db_password -Dspring.datasource.primary.password=$dms_db_password -Dspring.datasource.primary.username=$dms_db_username -Dapplication.submission.file-cabinet.username=$smb_sa_username -Dapplication.submission.file-cabinet.password=$smb_sa_password -Dtenantid=$tenantid -P dev --log-file run-logs.log"
    alias dms_run_local="mvn -Dspring.datasource.secondary.username=$dms_legacy_db_username -Dspring.datasource.secondary.password=$dms_legacy_db_password -Dspring.datasource.primary.password=$dms_db_password -Dspring.datasource.primary.username=$dms_db_username -Dapplication.submission.file-cabinet.username=$smb_sa_username -Dapplication.submission.file-cabinet.password=$smb_sa_password -Dtenantid=$tenantid -P local --log-file run-logs.log"

    alias c="clear"

    # trap 'npm run docker:redis:down && clear' EXIT
    trap 'clear' EXIT
  '';
}
