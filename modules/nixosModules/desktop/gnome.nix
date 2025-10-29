{
	self,
	...
}:{
	flake.nixosModules.gnome = {
		pkgs,
		config,
		...
	}: {
		services = {
			xserver = {
				enable = true;
				xkb = {
					layout = "us";
					variant = "";
				};
			};

			displayManager = {
				gdm = {
					enable = true;
					autoSuspend = false;
				};
				autoLogin = {
					enable = true;
					user = "${config.preferences.user.name}";
				};
			};

			desktopManager.gnome.enable = true;

			# Enable GNOME Remote Desktop Access
			gnome.gnome-remote-desktop.enable = true;
			xrdp = {
				enable = true;
				defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
				openFirewall = true;
			};
		};

		networking.firewall = {
			enable = true;
			allowedTCPPorts = [ 3389 ]; # Enable for xRDP
			allowedUDPPorts = [ 3389 ]; # Enable for xRDP
		};

		environment.systemPackages = with pkgs; [
			gnome-remote-desktop
			gnome-session
			xrdp
		];
	};
}
