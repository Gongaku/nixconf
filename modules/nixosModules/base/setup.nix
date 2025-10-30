{
	self,
	...
}:{
	flake.nixosModules.base = {
		pkgs,
		config,
		...
	}: let
		username = config.preferences.user.name;
	in{
		imports = [
			self.nixosModules.nix
		];

		# Setup default user
		users.users.${username} = {
			isNormalUser = true;
			description = "${username}'s account";
			extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.zsh;
			packages = [
				pkgs.fzf
			];
		};

		# Set your time zone.
		time.timeZone = "America/Denver";

		# Select internationalization properties.
		i18n = {
			defaultLocale = "en_US.UTF-8";
			extraLocaleSettings = {
				LC_ADDRESS = "en_US.UTF-8";
				LC_IDENTIFICATION = "en_US.UTF-8";
				LC_MEASUREMENT = "en_US.UTF-8";
				LC_MONETARY = "en_US.UTF-8";
				LC_NAME = "en_US.UTF-8";
				LC_NUMERIC = "en_US.UTF-8";
				LC_PAPER = "en_US.UTF-8";
				LC_TELEPHONE = "en_US.UTF-8";
				LC_TIME = "en_US.UTF-8";
			};
		};

		environment.sessionVariables = rec {
			XDG_CACHE_HOME = "$HOME/.cache";
			XDG_CONFIG_HOME = "$HOME/.config";
			XDG_DATA_HOME = "$HOME/.local/share";
			XDG_STATE_HOME = "$HOME/.local/state";
			XDG_BIN_HOME = "$HOME/.local/bin";
			PATH = [
				"${XDG_BIN_HOME}"
			];
		};
	};
}
