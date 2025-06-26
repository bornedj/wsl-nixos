let 
    nixpkgs = import <nixpkgs> { config.allowUnfree = true; };
in
{
    claude = nixpkgs.callPackage ./claude.nix { };
}
