{
	flake.applications.all_apps = { pkgs, ... }: {
		imports = [
			self.applications.git
			self.applications.browser
		];
	};
}
