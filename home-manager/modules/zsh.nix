{
	pkgs,
	config,
	...
}:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		enableGlobalCompInit = false;
		dotDir = ".config/zsh";
		shellAliases = {
			grep = "grep --color=auto";
			l = "ls -CFh";
			la = "ls -AlFh";
			ll = "ls -lhApF --color=always";
			ls = "ls -AphF --color=always";
			ipconfig = "ifconfig";
			q = "exit";
			":q" = "exit";
			rm = "rm -ifR";
			cp = "cp -i";
			mv = "mv -i";
			ln = "ln -i";
			wget = "wget -c";
			history = "history -i 0";
		};
	};

	programs.zsh.envExtra = ''
		# XDG Specs
		export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
		export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
		export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
		export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

		# Default applications
		export EDITOR="nvim"
		export VIDEO="mpv"

		# Misc
		export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
		export MINIKUBE_HOME="$XDG_CONFIG_HOME/"
		export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
		export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/.npmrc"
		export DOTNET_CLI_HOME="$XDG_CONFIG_HOME/.dotnet"

		# Less colors
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
		'';

	programs.zsh.initExtra = ''
		ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

		if [ ! -d "$ZINIT_HOME" ]; then
			mkdir -p "$(dirname $ZINIT_HOME)"
			git clone "https://github.com/zdharma-continuum/zinit.git" "$ZINIT_HOME"
		fi

		# Source zinit
		source "$ZINIT_HOME/zinit.zsh"

		# Plugins
		zinit ice wait lucid
		zinit load zsh-users/zsh-syntax-highlighting

		zinit ice wait lucid
		zinit load zsh-users/zsh-completions

		zinit ice wait lucid
		zinit load zsh-users/zsh-autosuggestions

		autoload -U compinit && compinit
		autoload -U colors && colors

		bindkey '^p' history-search-backward
		bindkey '^n' history-search-forward
		'';
};
