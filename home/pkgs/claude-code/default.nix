let 
    nixpkgs = import <nixpkgs> { };
in
{
    claude = nixpkgs.callPackage ./claude.nix { };
}
