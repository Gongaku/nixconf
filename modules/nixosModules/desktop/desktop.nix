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
