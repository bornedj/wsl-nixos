let
  nixpkgs = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
      sha256 = "0qmlr28ind35bqyswa8hagx7hx09k04s1dzxa4nllvwvi5r9yh9c";
  };
  pkgs = import nixpkgs { config = {}; overlays = []; system = "x86_64-linux"; };
in
{
  jhipster = pkgs.callPackage ./jhipster.nix {};
}

