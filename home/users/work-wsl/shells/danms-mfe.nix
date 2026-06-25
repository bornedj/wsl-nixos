{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
    packages = with pkgs; [
        cypress
    ];

    ANGULAR_BACKEND_ENV = "local";
    CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress";
    # NODE_EXTRA_CA_CERTS="/etc/ssl/certs/trusted.kmi.lan.crt";
    # NODE_TLS_REJECT_UNAUTHORIZED=0;

    shellHook = ''
      # exec zsh
      alias docker-create-network="docker network create dms-network"
      alias build-mfe-image="docker buildx build . --build-arg NPM_PUBLISH_TOKEN=$NPM_PUBLISH_TOKEN --build-arg ENV_NAME=local -t dms-mfe"
      alias run-mfe-container="docker run --rm -p 8081:8081 --name dms-mfe -e ANGULAR_BACKEND_ENV=local --network dms-network dms-mfe"
      alias stop-mfe-container="docker stop dms-mfe"

      trap 'clear' EXIT
    '';
}
