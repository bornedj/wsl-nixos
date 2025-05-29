let
  nixpkgs = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
      sha256 = "1ybhmmb9ph8ki7yicsnnvav4hxlh771zg82y642drsbbjs3f4szp";
  };
  pkgs = import nixpkgs { config = {}; overlays = []; system = "x86_64-linux"; };
in
{
  jhipster = pkgs.callPackage ./jhipster.nix {};
}

