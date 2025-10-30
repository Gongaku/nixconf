{
	# `Cachix` configurations
	# Pulls public binaries so that they do not need to be built
	nixConfig = {
		substituters = [
			# "https://cache.nixos.org/"
			"https://nixpkgs.cachix.org"
			"https://nix-community.cachix.org"
		];
		trusted-public-keys = [
			"nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
		];
		extra-substituters = [
			"https://nix-community.cachix.org"
		];
		extra-trusted-public-keys = [
			"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
		];
	};

  inputs = {
		# NixOS installation
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

		# Gaming
		nix-gaming.url = "github:fufexan/nix-gaming";
  };

	# Use a `Dendritic` pattern of nix configurations
	# More info: `https://vic.github.io/dendrix/Dendritic.html`
	outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
