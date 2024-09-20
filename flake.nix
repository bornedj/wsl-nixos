{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    # neovim plugins not found under pkgs.vimPlugins
    plugins-fugitive.url = "github:tpope/vim-fugitive";
    plugins-fugitive.flake = false;
    plugins-nvim-web-devicons.url = "github:nvim-tree/nvim-web-devicons";
    plugins-nvim-web-devicons.flake = false;
    plugins-angularls.url = "https://registry.npmjs.org/@angular/language-server/-/language-server-18.2.0.tgz";
    plugins-angularls.flake = false;
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-wsl, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
          }
          home-manager.nixosModules.home-manager
          {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true; 
              home-manager.users.nixos = import ../home/home.nix; 
              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
              ];
              home-manager.extraSpecialArgs = { inherit inputs;  };
          }
        ];
      };
      "home-wsl" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            nixos-wsl.nixosModules.default
            {
                system.stateVersion = "24.05";
                wsl.enable = true;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true; 
              home-manager.users.daniel = import ../home/users/home-wsl.nix;
              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
              ];
              home-manager.extraSpecialArgs = { inherit inputs;  };
            }
          ];
      };
    };
  };
}