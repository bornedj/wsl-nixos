{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Native build dependencies for cryptography, cffi, psycopg2
    openssl
    libffi
    postgresql
    pkg-config
    gcc
    # Provides libstdc++.so.6 required by numpy C-extensions on NixOS
    stdenv.cc.cc.lib
  ];

  packages = with pkgs; [
    python312
    poetry
  ];

  # Application environment variables
  DB_SCHEMA = "ktentref";
  # DB_HOST = "localhost:5432/dbktentref";

  REDIS_URL = "redis://localhost:6379";
  CACHE_TTL = 3600;

  FLASK_APP = "main";
  FLASK_DEBUG = "1";
  FLASK_RUN_PORT = "5000";
  ENV="local";
  API_VERSION = "v1";

  LOG_FORMAT = "text";
  LOG_LEVEL = "DEBUG";
  SERVICE_NAME = "dallas-enterprise-ref-api";

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH

    export DATABASE_URL="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.POSTGRES.DEV.ERD_USER_PASS_URL' | tr -d '"')"
    export DB_HOST="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.POSTGRES.DEV.ERD_URL' | tr -d '"')"
    export DB_USERNAME="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.POSTGRES.USERNAME' | tr -d '"')"
    export DB_PASSWORD="$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.DATABASE.POSTGRES.PASSWORD' | tr -d '"')"

    export OPENID="https://login.microsoftonline.com/$(sops decrypt /home/nixos/dotfiles/home/secrets/kinsale.yaml | yq '.SHARED.AZURE.DEV.TENANT_ID' | tr -d '"')/openid-configuration"

    export SERVICE_VERSION=$(git tag --sort=creatordate | tail -n 1)

    echo "Installing dependencies via poetry..."
    poetry install

    echo "Python environment ready. Python: $(poetry run python --version)"

    # Write .env so python-dotenv picks up the same values inside the process
    cat > .env <<EOF
env=$ENV
ENV=$ENV
FLASK_APP=$FLASK_APP
FLASK_DEBUG=$FLASK_DEBUG
FLASK_RUN_PORT=$FLASK_RUN_PORT
API_VERSION=$API_VERSION
DB_USERNAME=$DB_USERNAME
DB_PASSWORD=$DB_PASSWORD
DB_HOST=$DB_HOST
REDIS_URL=$REDIS_URL
LOG_FORMAT=$LOG_FORMAT
LOG_LEVEL=$LOG_LEVEL
SERVICE_NAME=$SERVICE_NAME
SERVICE_VERSION=$SERVICE_VERSION
EOF

    alias run='poetry run flask run'
    alias redis='docker run -d --name entref-redis --rm -p 6379:6379 redislabs/redismod'
    alias db='docker run -d --name entref-postgres --rm -p 5432:5432 \
      -e POSTGRES_DB=dbktentref \
      -e POSTGRES_USER=$DB_USERNAME \
      -e POSTGRES_PASSWORD=$DB_PASSWORD \
      postgres:16'
  '';
}
