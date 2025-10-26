{
  description = "My Nix Config";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          modules = [ ./hosts/nixos/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        nixos = lib.homeManagerConfiguration {
          modules = [ ./hosts/nixos/home.nix ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

        # Laptops
        # framework = lib.homeManagerConfiguration {
        #   modules = [ ./hosts/framework/home.nix ];
        #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
        #   extraSpecialArgs = { inherit inputs outputs; };
        # };

        # curve = lib.homeManagerConfiguration {
        #   modules = [ ./hosts/curve/home.nix ];
        #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
        #   extraSpecialArgs = { inherit inputs outputs; };
        # };
      };
    };
}

