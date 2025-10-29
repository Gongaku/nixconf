{
	self,
	...
}: {
	flake.apps.all_apps = {
		pkgs,
		...
	}: {
		imports = [
			self.apps.git
			self.apps.librewolf
		];
	};
}
