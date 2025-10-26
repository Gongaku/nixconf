{
  description = "My Nix Config";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
		nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
						./hosts/nixos/configuration.nix
					];
          # specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        nixos = inputs.home-manager.lib.homeManagerConfiguration {
					pkgs = import nixpkgs {
						system = "x86_64-linux";
						config.allowUnfree = true;
					};
					extraSpecialArgs = { inherit inputs; };
          modules = [
						./hosts/nixos/home.nix
						./home-manager/import.nix
					];
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          # extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}

