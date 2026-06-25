let
    pkgs = import <nixpkgs> { config = { allowUnfree = true;}; };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    cypress
    awscli2
  ];

  CYPRESS_INSTALL_BINARY=0;
  CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress";
  # CYPRESS_AUTH_AUDIENCE="https://kinsale-dev.us.auth0.com/api/v2/";
  # CYPRESS_AUTH_AUDIENCE="https://kinsale-qa.us.auth0.com/api/v2/";
  # CYPRESS_AUTH_AUDIENCE="https://kinsale-stage.us.auth0.com/api/v2/";


  shellHook = ''
    # export CYPRESS_PASSWORD=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PASSWORD' | tr -d '"')
    # export CYPRESS_USERNAME=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.USERNAME' | tr -d '"')
    # export CYPRESS_AZURE_PIP_READWRITE_EMAIL="pip.rw@azuredevkinsale.onmicrosoft.com"
    export CYPRESS_AZURE_PIP_READWRITE_EMAIL="pip.rw@kinsaleins.com"
    # export CYPRESS_AZURE_PIP_READWRITE_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_RW_LOWER_PASSWORD' | tr -d '"')";
    export CYPRESS_AZURE_PIP_READWRITE_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_RW_UPPER_PASSWORD' | tr -d '"')";
    export CYPRESS_EXTERNAL_USERNAME="pip.external@gmail.com";
    export CYPRESS_EXTERNAL_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.DMS_EXTERNAL_PASSWORD' | tr -d '"')"
    # export CYPRESS_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.QA.AUTH0_CLIENT_SECRET' | tr -d '"')"
    # export CYPRESS_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.QA.AUTH1_CLIENT_ID' | tr -d '"')"
    export CYPRESS_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.DEV.AUTH0_CLIENT_SECRET' | tr -d '"')"
    export CYPRESS_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.DEV.AUTH0_CLIENT_ID' | tr -d '"')"
    # export CYPRESS_CLIENT_SECRET="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.STAGE.AUTH0_CLIENT_SECRET' | tr -d '"')"
    # export CYPRESS_CLIENT_ID="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DMS_SHELL.STAGE.AUTH0_CLIENT_ID' | tr -d '"')"

    # db variables
    # export DATABASE_URL=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.QA.ISUBM_URL' | tr -d '"');
    export DATABASE_URL=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.DEV.ISUBM_URL' | tr -d '"');
    export DATABASE_PASSWORD=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.PASSWORD' | tr -d '"');
    export DATABASE_USERNAME=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.USERNAME' | tr -d '"');


    alias dev="npm run cypress:open:dev"
    alias qa="npm run cypress:open:qa"
    alias c="clear"

    trap 'clear' EXIT
  '';
}
