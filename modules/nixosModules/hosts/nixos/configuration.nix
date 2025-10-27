{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMain
    ];
  };

  flake.nixosModules.hostMain = {pkgs, ...}: {
    imports = [
      self.nixosModules.base
      self.nixosModules.general
      self.nixosModules.desktop

      # self.nixosModules.impermanence

      # self.nixosModules.gaming
      # self.nixosModules.discord
      # self.nixosModules.gimp
      # self.nixosModules.hyprland
      # self.nixosModules.telegram
      # self.nixosModules.youtube-music

      # self.nixosModules.vr

      # disko
      # inputs.disko.nixosModules.disko
      # self.diskoConfigurations.hostMain
    ];

    programs.corectrl.enable = true;

    boot = {
      loader.grub.enable = true;
			loader.systemd-boot.enable = true;
			loader.efi.canTouchEfiVariables = true;
      loader.grub.efiSupport = true;
      loader.grub.efiInstallAsRemovable = true;

      supportedFilesystems.ntfs = true;

      kernelParams = [
				"quiet"
				"amd_pstate=guided"
				"processor.max_cstate=1"
				"console=tty50,115200"
				"console=tty1"
			];
      kernelModules = [
				"coretemp"
				"cpuid"
				"v4l2loopback"
			];
    };

    # boot.plymouth.enable = true;

    # services.xserver.videoDrivers = ["amdgpu"];
    # boot.initrd.kernelModules = ["amdgpu"];

    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
      # firewall.enable = false;
			firewall = {
				enable = true;
				allowedTCPPorts = [ 3389 ]; # Enable for xRDP
				allowedUDPPorts = [ 3389 ]; # Enable for xRDP
			};
    };

    # virtualisation.libvirtd.enable = true;
    # virtualisation.podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   defaultNetwork.settings = {
    #     dns_enabled = true;
    #   };
    # };
    #
    # hardware.cpu.amd.updateMicrocode = true;
    #
    services = {
      # hardware.openrgb.enable = true;
      flatpak.enable = true;
      # udisks2.enable = true;
      printing.enable = true;

			xserver = {
				enable = true;
				xkb = {
					layout = "us";
					variant = "";
				};
			};

			displayManager.gdm = {
				enable = true;
				autoSuspend = false;
			};

  		desktopManager.gnome.enable = true;

			# Enable RDP
			gnome.gnome-remote-desktop.enable = true;
			xrdp = {
				enable = true;
				defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
				openFirewall = true;
			};

			# Allow laptop to keep running while lid is closed
			logind.lidSwitch = "ignore";

    };

		systemd.sleep.extraConfig = ''
			AllowSuspend=no
			AllowHibernation=no
			AllowHybridSleep=no
			AllowSuspendThenHibernate=no
		'';
    # programs.adb.enable = true;
    #
    # programs.alvr.enable = true;
    # programs.alvr.openFirewall = true;

    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      wineWowPackages.waylandFull
      winetricks
      glib
      bs-manager
    ];

    # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    # xdg.portal.enable = true;
    #
    hardware.graphics.enable = true;
    system.stateVersion = "25.11";
  };
}
