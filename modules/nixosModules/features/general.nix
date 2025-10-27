{ self, ... }: {
	flake.nixosModules.general = {
		pkgs, config, ...
	}: {
		imports = [
			self.nixosModules.extra_hjem
			self.nixosModules.nix
		];
		users.users.${config.preferences.user.name} = {
			isNormalUser = true;
			description = "${config.preferences.user.name}'s account";
			extraGroups = ["wheel" "networkmanager"];
			shell = self.packages.${pkgs.system}.environment;
			initialPassword = "12345";
		};
	};
}
