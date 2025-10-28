{
	self,
	...
}:{
	flake.nixosModules.setup = {
		pkgs,
		config,
		...
	}: {
		nix.settings.experimental-features = [ "nix-command" "flakes" ];
		nixpkgs.config.allowUnfree = true;

		users.users.${config.preferences.user.name} = {
			isNormalUser = true;
			description = "${config.preferences.user.name}'s account";
			extraGroups = [ "networkmanaager" "wheel" ];
			shell = pkgs.zsh;
		};
	};
}
