{
	self,
	...
}: {
	flake.nixosModules.all_apps = {
		pkgs,
		...
	}: {
		imports = [
			self.nixosModules.git
			self.nixosModules.librewolf
		];
	};
}
