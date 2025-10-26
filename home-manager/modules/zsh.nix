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
		histSize = 100000;
		setOptions = [
				"BANG_HIST"                 # Treat the '!' character specially during expansion.
				"EXTENDED_HISTORY"          # Write the history file in the ":start:elapsed;command" format.
				"INC_APPEND_HISTORY"        # Write to the history file immediately, not when the shell exits.
				"SHARE_HISTORY"             # Share history between all sessions.
				"HIST_EXPIRE_DUPS_FIRST"    # Expire duplicate entries first when trimming history.
				"HIST_IGNORE_DUPS"          # Don't record an entry that was just recorded again.
				"HIST_IGNORE_ALL_DUPS"      # Delete old recorded entry if new entry is a duplicate.
				"HIST_FIND_NO_DUPS"         # Do not display a line previously found.
				"HIST_IGNORE_SPACE"         # Don't record an entry starting with a space.
				"HIST_SAVE_NO_DUPS"         # Don't write duplicate entries in the history file.
				"HIST_REDUCE_BLANKS"        # Remove superfluous blanks before recording entry.
				"HIST_VERIFY"               # Don't execute immediately upon history expansion.
				"HIST_BEEP"                 # Beep when accessing nonexistent history.
		];

		autosuggestions = {
			enable = true;
			async = true;
		};

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
		autoload -U compinit && compinit
		autoload -U colors && colors

		NEWLINE=$(printf '\n ')
		PS1_USER="%{$(tput setaf 51)%}%n%F{reset_color}"
		PS1_HOST="%{$(tput setaf 46)%}%m%F{reset_color}"
		PS1_PATH="%F{red}%~%F{reset_color}"
		PS1_TIME="%{$(tput setaf 214)%}%D{%F %X %Z}%F{reset_color}"
		PS1="%B$PS1_USER@$PS1_HOST:$PS1_PATH%b [%B$PS1_TIME%b]$NEWLINE%j $ "
		export PS1

		bindkey '^p' history-search-backward
		bindkey '^n' history-search-forward
		'';
};
