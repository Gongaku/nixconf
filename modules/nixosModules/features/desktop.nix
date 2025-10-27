{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) getExe;
    selfpkgs = self.packages."${pkgs.system}";
  in {
    imports = [
      # self.nixosModules.gtk
      # self.nixosModules.wallpaper

      # self.nixosModules.pipewire
      # self.nixosModules.firefox
      # self.nixosModules.chromium
    ];

    # preferences.autostart = [selfpkgs.quickshellWrapped];

    # environment.systemPackages = [
    #   selfpkgs.terminal
    #   pkgs.pcmanfm
    # ];

    # fonts.packages = with pkgs; [
    #   nerd-fonts.jetbrains-mono
    #   cm_unicode
    #   corefonts
    # ];

    time.timeZone = "America/Denver";
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

    services.upower.enable = true;

		services.pulseaudio.enable = false;
		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			# If you want to use JACK applications, uncomment this
			#jack.enable = true;

			# use the example session manager (no others are packaged yet so this is enabled by default,
			# no need to redefine it in your config for now)
			#media-session.enable = true;
		};

    security.polkit.enable = true;

    hardware = {
      enableAllFirmware = true;

      # bluetooth.enable = true;
      # bluetooth.powerOnBoot = true;

      opengl = {
        enable = true;
        driSupport32Bit = true;
      };
    };

    # preferences.keymap = {
    #   "SUPERCONTROL + S".exec = ''
    #     ${getExe pkgs.grim} -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy'';
    #
    #   "SUPERSHIFT + E".exec = ''
    #     ${pkgs.wl-clipboard}/bin/wl-paste | ${getExe pkgs.swappy} -f -
    #   '';
    #
    #   "SUPERSHIFT + S".exec = ''
    #     ${getExe pkgs.grim} -g "$(${getExe pkgs.slurp} -w 0)" - \
    #     | ${pkgs.wl-clipboard}/bin/wl-copy
    #   '';
    #
    #   "SUPER + d"."b".package = pkgs.rofi-bluetooth;
    # };
  };
}
