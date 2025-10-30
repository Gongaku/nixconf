{
	flake.nixosModules.terminal = {
		pkgs,
		config,
		...
	}: {
		programs.zsh = {
			enable = true;
			enableCompletion = true;
			syntaxHighlighting.enable = true;
			# enableGlobalCompInit = false;

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

			shellInit = ''
				bindkey '^p' history-search-backward
				bindkey '^n' history-search-forward
			'';

			promptInit = ''
				# Source PS1
				source /home/${config.preferences.user.name}/zshenv

				autoload -U compinit && compinit
				autoload -U colors && colors
				autoload -U promptinit && promptinit && prompt suse && setopt prompt_sp
			'';
		};
	};
}

