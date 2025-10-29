{
	flake.nixosModules.base = { lib, ... }: let
		inherit (lib) mkOption types;
	in {
		options.preferences = {
			user.name = mkOption {
				type = types.str;
				default = "gongaku";
			};
			autostart = mkOption {
				type = types.listOf (types.either types.str types.package);
				default = [];
			};
		};
	};
}
