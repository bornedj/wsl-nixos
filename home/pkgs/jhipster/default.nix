let
  nixpkgs = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
      sha256 = "1wr1xzkw7v8biqqjcr867gbpqf3kibkgly36lcnhw0glvkr1i986";
  };
  pkgs = import nixpkgs { config = {}; overlays = []; system = "x86_64-linux"; };
in
{
  jhipster = pkgs.callPackage ./jhipster.nix {};
}

