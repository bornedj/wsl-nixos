let
    pkgs = import <nixpkgs> { config = { allowUnfree = true;}; };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    cypress
    nodejs_22
  ];

  CYPRESS_INSTALL_BINARY=0;
  CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress";

  shellHook = ''
    npx cypress open
  '';
}

