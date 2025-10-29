{
	flake.nixosModules.terminal = { pkgs, ... }: {
		programs.git = {
			enable = true;
			config = {
				user.name = "Gongaku";
				user.email = "132847661+Gongaku@users.noreply.github.com";
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
