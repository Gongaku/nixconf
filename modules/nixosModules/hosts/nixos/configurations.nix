{
	inputs,
	self,
	...
}: {
	flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			self.nixosModules.hostNixos
		];
	};

	flake.nixosModules.hostNixos = {pkgs, ...}: {
		imports = [
			self.nixosModules.base_config
			self.nixosModules.setup
			self.nixosModules.gnome
			self.nixosModules.openssh
		];
		boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = true;
		boot.kernelParams = [
			"console=tty50,115200"
			"console=tty1"
		];

		networking = {
			hostName = "nixos"; # Define your hostname.
			networkmanager.enable = true;
			firewall = {
				enable = true;
				allowedTCPPorts = [ 3389 ]; # Enable for xRDP
				allowedUDPPorts = [ 3389 ]; # Enable for xRDP
			};
		};

		# # Set your time zone.
		# time.timeZone = "America/Denver";
		#
		# # Select internationalisation properties.
		# i18n = {
		# 	defaultLocale = "en_US.UTF-8";
		# 	extraLocaleSettings = {
		# 		LC_ADDRESS = "en_US.UTF-8";
		# 		LC_IDENTIFICATION = "en_US.UTF-8";
		# 		LC_MEASUREMENT = "en_US.UTF-8";
		# 		LC_MONETARY = "en_US.UTF-8";
		# 		LC_NAME = "en_US.UTF-8";
		# 		LC_NUMERIC = "en_US.UTF-8";
		# 		LC_PAPER = "en_US.UTF-8";
		# 		LC_TELEPHONE = "en_US.UTF-8";
		# 		LC_TIME = "en_US.UTF-8";
		# 	};
		# };

		# Allow laptop to keep running while lid is closed
		services.logind.lidSwitch = "ignore";

		systemd.sleep.extraConfig = ''
			AllowSuspend=no
			AllowHibernation=no
			AllowHybridSleep=no
			AllowSuspendThenHibernate=no
		'';

		services.printing.enable = true;

		services.pulseaudio.enable = false;
		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};

		# Enable touchpad support (enabled default in most desktopManager).
		# services.xserver.libinput.enable = true;
		programs.zsh = {
			enable = true;
		};
		systemd.services."getty@tty1".enable = false;
		systemd.services."autovt@tty1".enable = false;

		programs.firefox.enable = true;

		environment.systemPackages = with pkgs; [
		 git
		 vim
		 wget
		 tmux
		 nettools
		];
		environment.variables.EDITOR = "vim";

		system.autoUpgrade = {
			enable = true;
			flake = inputs.self.outPath;
			flags = [
				"--update-input"
				"nixpkgs"
				"-L" # print build logs
			];
			dates = "02:00";
			randomizedDelaySec = "45min";
		};

		system.stateVersion = "25.11";
	};
}
