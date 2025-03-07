let
  nixpkgs = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
      sha256 = "0h3yzgn0mw74039xaqpvhvd2f924d923ax3kb8gh79f2m1jgla6i";
  };
  pkgs = import nixpkgs { config = {}; overlays = []; system = "x86_64-linux"; };
in
{
  jhipster = pkgs.callPackage ./jhipster.nix {};
}

