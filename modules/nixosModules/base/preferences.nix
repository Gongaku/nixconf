{
	flake.nixosModules.base = { lib, ... }: let
		inherit (lib) mkOption types;
	in {
		options.preferences = {
			# User
			user.name = mkOption {
				type = types.str;
				default = "gongaku";
			};
			# Auto-start
			autostart = mkOption {
				type = types.listOf (types.either types.str types.package);
				default = [];
			};
		};
	};
}
