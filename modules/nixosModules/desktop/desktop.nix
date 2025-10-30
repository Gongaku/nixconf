{
	self,
	...
}: {
	flake.nixosModules.desktop = {
		pkgs,
		...
	}: {
		imports = [
			self.nixosModules.gnome
			self.nixosModules.librewolf
			self.nixosModules.discord
		];

		environment.systemPackages = with pkgs; [
		 git
		 vim
		 wget
		 tmux
		 nettools
		];
		environment.variables.EDITOR = "vim";
	};
}
