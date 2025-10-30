{
  inputs = {
		# NixOS installation
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# wrappers.url = "github:Lassulus/wrappers/39b27c1bbf6cfc38afb570f98664540639fc52f8";

		# Core of a distributed framework for writing Nix Flakes
		# More info: `https://flake.parts`
    flake-parts.url = "github:hercules-ci/flake-parts";

		# Import modules in a tree like hierarchy
    import-tree.url = "github:vic/import-tree";

		# Nix Index tooling to quickly locate the package providing a certain
		# file in `nixpkgs`. It indexes built derivations found in binary caches
		nix-index-database = {
			url = "github:Mic92/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# NixOS User Repository
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# "Home" in Danish. Similar to Home-Manager, used for managing one's
		# home directory contents
		hjem = {
			url = "github:feel-co/hjem";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# NixOS Home Manager. For managing one's home directory contents
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Firefox theme
		textfox.url = "github:adriankarlen/textfox";
  };

	# Use a `Dendritic` pattern of nix configurations
	# More info: `https://vic.github.io/dendrix/Dendritic.html`
	outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
