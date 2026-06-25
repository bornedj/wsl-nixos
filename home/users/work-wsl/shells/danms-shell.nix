let
    pkgs = import <nixpkgs> { config = { allowUnfree = true;}; };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    cypress
    awscli2
  ];

  # AWS_PROFILE = "prod";
  CYPRESS_INSTALL_BINARY=0;
  CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress";
  # CYPRESS_AUTH_AUDIENCE="https://kinsale-dev.us.auth0.com/api/v2/";
  # CYPRESS_AUTH_AUDIENCE="https://kinsale-qa.us.auth0.com/api/v2/";
  CYPRESS_AUTH_AUDIENCE="https://kinsale-stage.us.auth0.com/api/v2/";
  # NODE_EXTRA_CA_CERTS="/etc/ssl/certs/trusted.kmi.lan.crt";
  # NODE_TLS_REJECT_UNAUTHORIZED=0;

  shellHook = ''
    # exec zsh
    # export CYPRESS_PASSWORD=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PASSWORD' | tr -d '"')
    # export CYPRESS_USERNAME=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.USERNAME' | tr -d "')
    export CYPRESS_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_RW_UPPER_PASSWORD' | tr -d '"')";
    export CYPRESS_USERNAME="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_RW_UPPER_USERNAME' | tr -d '"')";
    export CYPRESS_EXTERNAL_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.DMS_EXTERNAL_PASSWORD' | tr -d '"')"
    # export CYPRESS_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.QA.AUTH0_CLIENT_SECRET' | tr -d '"')"
    # export CYPRESS_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.QA.AUTH1_CLIENT_ID' | tr -d '"')"
    export CYPRESS_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.DEV.AUTH0_CLIENT_SECRET' | tr -d '"')"
    export CYPRESS_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.DEV.AUTH0_CLIENT_ID' | tr -d '"')"
    # export CYPRESS_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.STAGE.AUTH0_CLIENT_SECRET' | tr -d '"')"
    # export CYPRESS_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.STAGE.AUTH0_CLIENT_ID' | tr -d '"')"
    # export CYPRESS_DMS_MFE_VERSION="$(git branch --show-current | tr -d '\n')"
    export CYPRESS_DMS_MFE_VERSION="20.26.3"

    # db variables
    # export DATABASE_URL=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.DEV.ISUBM_URL' | tr -d '"');
    # export DATABASE_URL=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.QA.ISUBM_URL' | tr -d '"');
    export DATABASE_URL=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.STAGE.ISUBM_URL' | tr -d '"');
    export DATABASE_PASSWORD=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.PASSWORD' | tr -d '"');
    export DATABASE_USERNAME=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.USERNAME' | tr -d '"');

    alias docker-create-network="docker network create dms-network"
    alias docker-build-shell="docker buildx build . --build-arg NPM_PUBLISH_TOKEN=$NPM_PUBLISH_TOKEN --build-arg ENV_NAME=local --build-arg DMS_MFE_VERSION=20.0.0 -t dms-shell"
    alias run-shell-container="docker run --rm -p 8080:8080 --name dms-shell -e ANGULAR_BACKEND_ENV=local --network dms-network dms-shell"
    alias stop-shell-container="docker stop dms-shell"
    alias dev="npm run cypress:open:dev"
    alias qa="npm run cypress:open:qa"
    alias c="clear"

    trap 'clear' EXIT
  '';
}
