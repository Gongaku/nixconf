{
	flake.nixosModules.librewolf = { pkgs, ... }: {
		programs.firefox = {
			enable = true;
			package = pkgs.librewolf;
			policies = {
				DisableTelemetry = true;
				DisableFirefoxStudies = true;
				Preferences = {
					"cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
					"cookiebanners.service.mode" = 2; # Block cookie banners
					"privacy.donottrackheader.enabled" = true;
					"privacy.fingerprintingProtection" = true;
					"privacy.resistFingerprinting" = true;
					"privacy.trackingprotection.emailtracking.enabled" = true;
					"privacy.trackingprotection.enabled" = true;
					"privacy.trackingprotection.fingerprinting.enabled" = true;
					"privacy.trackingprotection.socialtracking.enabled" = true;
				};
				ExtensionSettings = {
					"jid1-ZAdIEUB7XOzOJw@jetpack" = {
						install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
						installation_mode = "force_installed";
					};
					"uBlock0@raymondhill.net" = {
						install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
						installation_mode = "force_installed";
					};
				};
			};
		};

		environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";

		# Theme
		textfox = {
			enable = true;
			profile = "textfox";
			config = {
				background = {
					color = "#123456";
				};
				border = {
					color = "#654321";
					width = "4px";
					transition = "1.0s ease";
					radius = "3px";
				};
				displayHorizontalTabs = true;
				displayWindowControls = true;
				displayNavButtons = true;
				displayUrlbarIcons = true;
				displaySidebarTools = false;
				displayTitles = false;
				newtabLogo = "   __            __  ____          \A   / /____  _  __/ /_/ __/___  _  __\A  / __/ _ \\| |/_/ __/ /_/ __ \\| |/_/\A / /_/  __/>  </ /_/ __/ /_/ />  <  \A \\__/\\___/_/|_|\\__/_/  \\____/_/|_|  ";
				font = {
					family = "Fira Code";
					size = "15px";
					accent = "#654321";
				};
				sidebery = {
					margin = "1.0rem";
				};
			};
		};
	};
}
