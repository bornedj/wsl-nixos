let 
    pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    terraform
  ];
}
