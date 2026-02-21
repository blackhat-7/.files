{
  description = "Linux Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, system-manager, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
      
      username = "illusion";
    in {
      # Home Manager configuration for Linux
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      # System configuration with system-manager
      systemConfigs.illusionPC = system-manager.lib.makeSystemConfig {
        modules = [
          ./linux
          {
            nixpkgs = {
              config.allowUnfree = true;
              hostPlatform = "x86_64-linux";
            };
            system-manager.allowAnyDistro = true;
            users.mutableUsers = true;
          }
        ];
      };

      # Development shells
      devShells = forAllSystems (system: {
        default = nixpkgsFor.${system}.mkShell {
          packages = with nixpkgsFor.${system}; [ nixfmt ];
        };
      });
    };
}
