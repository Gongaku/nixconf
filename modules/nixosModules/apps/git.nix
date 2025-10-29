{
	flake.nixosModules.git = { pkgs, ... }: {
		programs.git = {
			enable = true;
			userName = "Gongaku";
			userEmail = "132847661+Gongaku@users.noreply.github.com";
			config = {
				init = {
					defaultBranch = "main";
				};
				push = {
					autoSetupRemote = true;
				};
			};
		};
	};
}
