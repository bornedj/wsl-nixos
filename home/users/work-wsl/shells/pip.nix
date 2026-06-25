{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    cypress
  ];

  CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress";
  DOCKER_BUILDKIT = 1;

  shellHook = ''
      # export CYPRESS_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_RW_LOWER_PASSWORD' | tr -d '"')";
      # export CYPRESS_USERNAME="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_RW_LOWER_USERNAME' | tr -d '"')";
      export CYPRESS_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.PASSWORD' | tr -d '"')";
      export CYPRESS_USERNAME="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.USERNAME' | tr -d '"')";
      export CYPRESS_STAGE_USERNAME=$CYPRESS_USERNAME;
      export CYPRESS_STAGE_PASSWORD=$CYPRESS_PASSWORD;
      export CYPRESS_ENVIRONMENT="STAGE";
      export CYPRESS_EXTERNAL_USERNAME="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_EXTERNAL_USERNAME' | tr -d '"')";
      export CYPRESS_EXTERNAL_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TESTING_ACCOUNTS.PIP_EXTERNAL_PASSWORD' | tr -d '"')"
      export JIRA_USER="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.XRAY.JIRA_USER' | tr -d '"')"

      alias build-pip-image="docker buildx build . --build-arg NPM_PUBLISH_TOKEN=$NPM_PUBLISH_TOKEN -t aspera-pi-portal"
      alias run-pip-container="docker run --rm -p 8080:8080 --name aspera-pi-portal -e ANGULAR_BACKEND_ENV=dev aspera-pi-portal"
      alias stop-pip-container="docker stop aspera-pi-portal"
      alias c="clear"

      trap 'c' EXIT
      # trap 'stop-pip-container && clear' EXIT
  '';
}
