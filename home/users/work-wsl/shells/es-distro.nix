{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {

  packages = with pkgs; [
    bruno-cli
  ];

  AWS_PRPOFILE="nonprod";
  SPRING_PROFILES_ACTIVE="dev";
  XRAY_URL="https://xray.cloud.getxray.app";
  REPORT_PATH="bruno/distribution-service/reports/validations.xml";
  XRAY_TEST_PLAN="ESS-1601";
  XRAY_PROJECT="ESS";
  ENVIRONMENT="dev";

  shellHook = ''
    export db_username_dbktentcorr="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.POSTGRES.USERNAME' | tr -d '"')"
    export db_password_dbktentcorr="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.POSTGRES.PASSWORD' | tr -d '"')"

    export dev_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_DISTRIBUTION.DEV.CLIENT_ID' | tr -d '"')"
    export dev_client_secret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_DISTRIBUTION.DEV.CLIENT_SECRET' | tr -d '"')"
    export qa_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_DISTRIBUTION.QA.CLIENT_ID' | tr -d '"')"
    export qa_client_secret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.ESS_DISTRIBUTION.QA.CLIENT_SECRET' | tr -d '"')"
    export clientid=$dev_client_id
    export clientsecret=$dev_client_secret

    export dmsclientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS.CLIENT_SECRET' | tr -d '"')"
    export tenantid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')"
    export BRUNO_RUN_OPTIONS="--reporter-junit reports/validations.xml"
    export XRAY_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.XRAY.CLIENT_ID' | tr -d '"')"
    export XRAY_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.XRAY.CLIENT_SECRET' | tr -d '"')"
    export REPORT_UPLOAD_URL="$XRAY_URL/api/v2/import/execution/junit/multipart"

    export automated_testing_dev_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_ID' | tr -d '"')"
    export automated_testing_dev_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.DEV.CLIENT_SECRET' | tr -d '"')"
    export automated_testing_qa_client_id=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_ID' | tr -d '"')"
    export automated_testing_qa_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.AUTOMATED_PIPELINE_TESTING.QA.CLIENT_SECRET' | tr -d '"')"

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

    test_bru() {
        auth_dev
        cd bruno/distribution-service
        eval bru run $BRUNO_RUN_OPTIONS --env-var ENTERPRISE_SOLUTIONS_DISTRIBUTION_SERVICE_AZURE_TOKEN=$TOKEN --env $ENVIRONMENT
    }

    xray() {
      cd /home/nixos/gitlab_linux/enterprise-solutions-distribution-service
      XRAY_TOKEN=$(curl -s -X POST \
        -H "Content-Type: application/json" \
        -d "{\"client_id\": \"$XRAY_CLIENT_ID\", \"client_secret\": \"$XRAY_CLIENT_SECRET\"}" \
        "$XRAY_URL/api/v2/authenticate"| tr -d '"')

      TEST_EXECUTION_INFO=$(jq -n \
        --arg summary "$ENVIRONMENT: Regression Test Execution for [$XRAY_TEST_PLAN]" \
        --arg testPlanKey "$XRAY_TEST_PLAN" \
        --arg projectKey "$XRAY_PROJECT" \
        '{
          fields: {
            summary: $summary,
            project: { key: $projectKey },
            issuetype: { name: "Test Execution" }
          },
          xrayFields: {
            testPlanKey: $testPlanKey
          }
        }')

      echo "Test Execution Info Payload:"
      echo "$TEST_EXECUTION_INFO" > test_execution_info.json

      RESPONSE=$(curl -X POST \
        -H "Authorization: Bearer $XRAY_TOKEN" \
        -F "results=@$REPORT_PATH;type=text/xml" \
        -F "info=@test_execution_info.json;type=application/json" \
        "$REPORT_UPLOAD_URL")

      echo $RESPONSE
    }

    trap 'clear' EXIT
  '';
}
