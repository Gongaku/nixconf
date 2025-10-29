{
	inputs,
	...
}: {
	flake.nixosModules.base = {
		config,
		...
	}: let
		user = config.preferences.user.name;
	in {
		imports = [
			inputs.hjem.nixosModules.default
		];

		config = {
			hjem = {
				users."${user}" = {
					enable = true;
					directory = "/home/${user}";
					user = "${user}";
				};

				xdg.config.files = {
					"test".text = "test";
				};

				clobberByDefault = true;
			};
		};
	};
}
