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
    plugin-nvim-web-devicons.url = "github:nvim-tree/nvim-web-devicons";
    plugin-nvim-web-devicons.flake = false;
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
              home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];

      };
    };
  };
}
