{
	inputs,
	self,
	...
}: {
	flake.nixosModules.base = {
		config,
		...
	}: let
		user = config.preferences.user.name;
		dotfiles_path = (self + "/dotfiles");
	in {
		imports = [
			inputs.hjem.nixosModules.default
		];

		config = {
			hjem = {
				users."${user}" = {
					enable = true;
					directory = "/home/${user}";
					user = "${user}";

					files = {
						".zshenv".text = "ZDOTDIR=$HOME/.config/zsh";
					};
					xdg.config.files = {
						"test".text = "test";
						"zsh/zshrc".source = (dotfiles_path + "zshrc");
					};
				};

				clobberByDefault = true;
			};
		};
	};
}
