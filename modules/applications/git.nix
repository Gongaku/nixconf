{
	flake.applications.git = { pkgs, ... }: {
		programs.git = {
			enable = true;
			userName = "Gongaku";
			userEmail = "132847661+Gongaku@users.noreply.github.com";
			extraConfig = {
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
