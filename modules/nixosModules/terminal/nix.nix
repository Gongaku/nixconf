{
	inputs,
	...
}: {
	flake.nixosModules.nix = {
		pkgs,
		...
	}: {
		imports = [
			inputs.nix-index-database.nixosModules.nix-index
		];
		# Enable nix-index tooling
		programs.nix-index-database.comma.enable = true;
		# Enable flakes
		nix.settings.experimental-features = [ "nix-command" "flakes" ];
		# Enable unfree software
		nixpkgs.config.allowUnfree = true;
	};
}
