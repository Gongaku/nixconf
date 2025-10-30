{
	inputs,
	...
}: {
	flake.nixosModules.home-manager = {
		config,
		pkgs,
		...
	}: let
		user = config.preferences.user.name;
	in {
		imports = [
			inputs.home-manager.nixosModules.default
		];

		programs.home-manager.enable = true;

		config = {
			home-manager = {
				home = {
					username = "${user}";
					homeDirectory = "/home/${user}";
					home.packages = [
						pkgs.htop
					];
					stateVersion = "25.11";
				};
			};
		};
	};
}
