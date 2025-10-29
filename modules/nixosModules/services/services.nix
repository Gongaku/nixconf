{
	self,
	...
}:{
	flake.nixosModules.services = {
		pkgs,
		config,
		...
	}: {
		# SSH config
		services.openssh = {
			enable = true;
			settings = {
				X11Forwarding = true;
				PermitRootLogin = "no";
			};
			openFirewall = true;
		};

		# Allow laptop to keep running while lid is closed
		services.logind.settings.Login.HandleLidSwitch = "ignore";

		# Do not sleep
		systemd.sleep.extraConfig = ''
			AllowSuspend=no
			AllowHibernation=no
			AllowHybridSleep=no
			AllowSuspendThenHibernate=no
		'';

		# Teletypewriter (`TTY`) interface
		systemd.services."getty@tty1".enable = false;
		systemd.services."autovt@tty1".enable = false;

		# Audio Config
		services.pulseaudio.enable = false; security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};

		services.printing.enable = true;

		# Enable touchpad support (enabled default in most desktopManager).
		# services.xserver.libinput.enable = true;
	};
}

