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

	flake.nixosModules.hostNixos = { pkgs, ... }: {
		imports = [
			self.nixosModules.base
			self.nixosModules.services
			self.nixosModules.terminal
			self.nixosModules.desktop
		];

		boot = {
			loader = {
				systemd-boot.enable = true;
				efi.canTouchEfiVariables = true;
			};
			kernelParams = [
				"console=tty50,115200"
				"console=tty1"
			];
		};

		networking = {
			hostName = "nixos"; # Define your hostname.
			networkmanager.enable = true;
		};

		programs.zsh = {
			enable = true;
		};

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
