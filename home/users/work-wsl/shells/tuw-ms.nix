{pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    maven
    jdk17
    temurin-bin-17
  ];

  SPRING_PROFILES_ACTIVE = "dev";

  shellHook = ''
    export dbktuw_password=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TUW.DB.DBKTUW.PASSWORD' | tr -d '"')
    export dbktuw_username=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TUW.DB.DBKTUW.USERNAME' | tr -d '"')
    export tuw_client_secret=$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.TUW.CLIENT_SECRET' | tr -d '"')

    alias tuw_run_local="mvn -Dspring.datasource.username=$dbktuw_username -Dspring.datasource.password=$dbktuw_password -Dtuws-client-secret=$tuw_client_secret -Dspring.profiles.active=local -P local "
    alias tuw_run_dev="mvn -Dspring.datasource.username=$dbktuw_username -Dspring.datasource.password=$dbktuw_password -Dtuws-client-secret=$tuw_client_secret -Dspring.profiles.active=dev -P dev"

    alias c="clear"

    trap 'clear' EXIT
  '';
}
