{
	flake.nixosModules.terminal = { pkgs, ... }: {
		programs.tmux = {
			enable = true;
			baseIndex = 1;
			terminal = "tmux-256color";
			aggressiveResize = true;
			escapeTime = 10;
		};
	};
}
