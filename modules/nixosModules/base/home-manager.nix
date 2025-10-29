{
  flake.nixosModules.home-manager = {
		config,
		pkgs,
		...
	}: let
		user = config.preferences.user.name;
	in {
		home = {
			username = "${user}";
			homeDirectory = "/home/${user}";
			stateVersion = "25.11"
		};

		programs.home-manager.enable = true;
	};
}
