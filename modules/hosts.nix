{ inputs, ... }: {
	flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			self.nixosModules.hostNixos
		];
	};
}
