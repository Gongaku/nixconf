{
	inputs,
	self,
	...
}: {
	flake.nixosModules.base = {
		config,
		pkgs,
		...
	}: let
		user = config.preferences.user.name;
		dotfiles_path = (self + "/dotfiles");
	in {
		imports = [
			inputs.home-manager.nixosModules.default
		];

		programs.home-manager.enable = true;

		config = {
			home-manager = {
				home = {
					username = "${user}";
					homeDirectory = "/home/${user}";
					packages = [
						pkgs.htop
					];
					stateVersion = "25.11";
					file."test".text = "IDK";
					file.".zshenv".text = "ZDOTDIR=/home/${user}/.config/zsh";
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
			};
		};
	};
}
