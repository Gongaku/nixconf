{
	inputs,
	self,
	...
}: {
	flake.nixosModules.hjem = {
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
						".zshenv".text = "ZDOTDIR=/home/${user}/.config/zsh";
					};
					xdg.config.files = {
						# Symlink for `zshrc`
						# Used for Shell Prompt (i.e. `PS1`)
						"zsh/zshrc".source = (dotfiles_path + "/zshrc");

						# Python LSP style
						# Ignore specific errors
						"pycodestyle".text = ''
							[pycodestyle]
							ignore = E226,E302,E41,W503,E501
						'';
					};
				};

				clobberByDefault = true;
			};
		};
	};
}
