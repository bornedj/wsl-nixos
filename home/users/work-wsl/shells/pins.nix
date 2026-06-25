{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  SPRING_PROFILES_ACTIVE="dev";

  shellHook = ''
    export personalinsuranceservice_db_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.USERNAME' | tr -d '"')"
    export personalinsuranceservice_db_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.PASSWORD' | tr -d '"')"
    export redis_auth_url="redis://localhost:6379"
    # export CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.auth0.CLIENT_ID' | tr -d '"')";
    # export CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.auth0.CLIENT_SECRET' | tr -d '"')";
    export clientid_si="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.AZURE_SI.CLIENT_ID' | tr -d '"')";
    export clientsecret_si="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.AZURE_SI.CLIENT_SECRET' | tr -d '"')";
    export clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.AZURE_SI.CLIENT_ID' | tr -d '"')";
    export clientsecret="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.AZURE_SI.CLIENT_SECRET' | tr -d '"')";
    export lexisnexis_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.LEXIS_NEXIS.USERNAME' | tr -d '"')";
    export lexisnexis_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.LEXIS_NEXIS.PASSWORD' | tr -d '"')"
    export lexisnexis_account_number="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.LEXIS_NEXIS.ACCOUNT_NUMBER' | tr -d '"')"
    export lexisnexis_client_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.LEXIS_NEXIS.CLIENT_ID' | tr -d '"')"
    export unleash_instance_id="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.UNLEASH.INSTANCE_ID' | tr -d '"')"
    export unleash="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PIS.UNLEASH.INSTANCE_ID' | tr -d '"')"
    export tenantid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')"
    export dms_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS.CLIENT_ID' | tr -d '"')"
    export nms_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.CLIENT_ID' | tr -d '"')"
    export hhs_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.HHS.CLIENT_ID' | tr -d '"')"
    export nis_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NIS.CLIENT_ID' | tr -d '"')"
    export dallas_pii_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DALLAS_PII.CLIENT_ID' | tr -d '"')"
    export policy_service_clientid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.POLICY_SERVICE.CLIENT_ID' | tr -d '"')"
    export JAVA_OPTS="-Dspring.datasource.username=$USERNAME -Dspring.datasource.password=$PASSWORD -Dspring.cloud.aws.credentials.profile.name=nonprod -Dclientid=$clientid -Dclientsecret=$clientsecret -Dclientid-si=$clientid_si -Dclientsecret-si=$clientsecret_si -Dlexisnexis-username=$lexisnexis_username -Dlexisnexis-password=$lexisnexis_password -Dlexisnexis-account-number=$lexisnexis_account_number -Dlexisnexis-client-id=$lexisnexis_client_id -Djhipster.cache.redis.server=redis://localhost:6379 -Dunleash-instance-id=$unleash_instance_id -Dtenantid=$tenantid -Ddms-clientid=$dms_clientid -Dnms-clientid=$nms_clientid -Dhhs-clientid=$hhs_clientid -Dnis-clientid=$nis_clientid -Ddallas-pii-clientid=$dallas_pii_clientid -Dpolicy-service-clientid=$policy_service_clientid"
    # export SPRING_DATASOURCE_PASSWORD=$PASSWORD
    # export SPRING_DATASOURCE_USERNAME=$USERNAME

    # alias pis_run="mvn -Dspring.datasource.username=$USERNAME -Dspring.datasource.password=$PASSWORD -Djhipster.cache.redis.server=redis://localhost:6379 -Dclientid=$clientid -Dclientsecret=$clientsecret -Dclientid-si=$clientid_si -Dclientsecret_si=$clientsecret_si -Dspring-boot.run.profiles=dev -Dspring.cloud.aws.credentials.profile.name=nonprod -P dev,api-docs"
    alias pis_build="./mvnw install"
    alias pis_run="./mvnw -pl pip-app spring-boot:run"

    # npm run docker:redis:up
    # pis_run

    # trap "npm run docker:redis:down && clear" EXIT
    trap 'clear' EXIT
  '';
}
