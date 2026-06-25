{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    maven
    jdk17
    temurin-bin-17
  ];

  SPRING_PROFILES_ACTIVE="dev";

  shellHook = ''
    npm run docker:redis:up
    export dms_legacy_db_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.LEGACY.USERNAME' | tr -d '"')"
    export dms_legacy_db_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.LEGACY.PASSWORD' | tr -d '"')"
    export dms_db_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.TARGET_STATE.USERNAME')"
    export dms_db_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.TARGET_STATE.PASSWORD')"
    export smb_sa_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.SMB.PASSWORD' | tr -d '"')"
    export smb_sa_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.FILE_CABINET.SMB.USERNAME' | tr -d '"')"
    export nms_db_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.DATABASE.PASSWORD' | tr -d '"')"
    export nms_db_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.DATABASE.USERNAME' | tr -d '"')"
    export nms_legacy_db_password="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.DATABASE.LEGACY.PASSWORD' | tr -d '"')"
    export nms_legacy_db_username="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.NMS.DATABASE.LEGACY.USERNAME' | tr -d '"')"
    export tenantid="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')"
    # export AWS_ACCESS_KEY_ID="$(sed -n '/\[nonprod\]/,/^\[/p' /home/nixos/.aws/credentials | rg aws_access_key_id | cut -d'=' -f2)"

    export db_url=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.QA.ISUBM_URL' | tr -d '"')
    # alias danmscs_run="mvn -Dspring.datasource.transit-document.username=$dms_db_username -Dspring.datasource.transit-document.password=$dms_db_password -Dspring.datasource.legacy-document.username=$dms_legacy_db_username -Dspring.datasource.legacy-document.password=$dms_legacy_db_password -Dspring.datasource.transit-note.username=$nms_db_username -Dspring.datasource.transit-note.password=$nms_db_password -Dspring.datasource.legacy-note.username=$nms_legacy_db_username -Dspring.datasource.legacy-note.password=$nms_legacy_db_password -Dapplication.submission.file-cabinet.username=$smb_sa_username -Dapplication.submission.file-cabinet.password=$smb_sa_password"
    alias danmscs_run="mvn -Dspring.datasource.transit-document.username=$dms_db_username -Dspring.datasource.transit-document.password=$dms_db_password -Dspring.datasource.legacy-document.username=$dms_legacy_db_username -Dspring.datasource.legacy-document.password=$dms_legacy_db_password -Dspring.datasource.transit-note.username=$nms_db_username -Dspring.datasource.transit-note.password=$nms_db_password -Dspring.datasource.legacy-note.username=$nms_legacy_db_username -Dspring.datasource.legacy-note.password=$nms_legacy_db_password -Dapplication.submission.file-cabinet.username=$smb_sa_username -Dapplication.submission.file-cabinet.password=$smb_sa_password -Dspring.profiles.active=dev -P dev"

    alias c="clear"

    # trap 'clear' EXIT
    trap 'npm run docker:redis:down && clear' EXIT
  '';
}
