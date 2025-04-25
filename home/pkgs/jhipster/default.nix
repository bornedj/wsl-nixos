let
  nixpkgs = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
      sha256 = "1p3mbqpj4nhq88vnfcajq8yw7mp6bf7s63n10a0hg38d3pfj42hm";
  };
  pkgs = import nixpkgs { config = {}; overlays = []; system = "x86_64-linux"; };
in
{
  jhipster = pkgs.callPackage ./jhipster.nix {};
}

