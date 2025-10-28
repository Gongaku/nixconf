{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		# wrappers.url = "github:Lassulus/wrappers/39b27c1bbf6cfc38afb570f98664540639fc52f8";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

	outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
