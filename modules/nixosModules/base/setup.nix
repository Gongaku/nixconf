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
		# Enable flakes
		nix.settings.experimental-features = [ "nix-command" "flakes" ];
		# Enable unfree software
		nixpkgs.config.allowUnfree = true;

		# Setup default user
		# users.users.${config.preferences.user.name} = {
		users.users.${username} = {
			isNormalUser = true;
			description = "${username}'s account";
			extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.zsh;
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
	};
}
