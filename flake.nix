{
  description = "NixOS configuration";

  inputs = {
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    certs.url = "git+ssh://git@gitlab.com/danielborne/certs.git";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-wsl, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = with inputs; { inherit certs; };
        modules = [
          nixos-wsl.nixosModules.default
          ./nixos/work-wsl.nix
          {
            system.stateVersion = "24.11";
            wsl.enable = true;
          }
          home-manager.nixosModules.home-manager
          {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true; 
              home-manager.users.nixos = import ./home/users/work-wsl; 
              home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
      "home-wsl" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/home-wsl.nix
            nixos-wsl.nixosModules.default
            {
                system.stateVersion = "24.11";
                wsl.enable = true;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true; 
              home-manager.users.daniel = import ./home/users/home-wsl;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
      };
    };
  };
}
