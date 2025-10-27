{ config, pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		newSession = true;
		prefix = "C-Space";
		terminal = "tmux-256color";
		baseIndex = 1;
		escapeTime = 10;
		aggressiveResize = true;

		extraConfig = ''
			#-----------------------------
			# Miscellaneous Settings
			#-----------------------------
			if-shell -b '[ "$(uname)" = "Darwin" ]' {
				# If system is OSX
				# Set prefix to control+b on Mac
				set -g prefix ^b
				set -g prefix2 ^Space
				bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
				bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
			} {
				# Else system is Linux
				set -g prefix2 C-Space
				bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
				bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -out -selection clipboard'
			}
			# Quick Reload Tmux Config
			bind r source-file "$TMUX_DIR/tmux.conf" \; \
				display "Config '$TMUX_DIR/tmux.conf' reloaded!"

			# Renumbers windows if one closes
			set -g renumber-windows on

			# Set window notifications
			setw -g monitor-activity on
			set -g visual-activity on

			# Automatically set window title
			setw -g automatic-rename off

			# Use vim keybindings in copy mode
			setw -g mode-keys vi
			bind -T copy-mode-vi v send -X begin-selection
			bind -T copy-mode-vi V send -X rectangle-toggle
			bind P paste-buffer

			#-----------------------------
			# Status Bar Styling
			#-----------------------------
			set-option -g status-justify left
			set-option -g status-left '#[bg=colour72] #[bg=colour237] #[bg=colour236] #[bg=colour235]#[fg=colour185] #S #[bg=colour236] '
			set-option -g status-left-length 16
			set-option -g status-bg colour237
			set-option -g status-right '#[bg=colour236] #[bg=colour235]#[fg=colour185] %a %F %R #[bg=colour236]#[fg=colour3] #[bg=colour237] #[bg=colour72] #[]'
			set-option -g status-interval 60

			#-----------------------------
			# Window Styling
			#-----------------------------
			set-window-option -g window-status-format '#[bg=colour238]#[fg=colour107] #I #[bg=colour239]#[fg=colour110] #[bg=colour240]#W#[bg=colour239]#[fg=colour195]#F#[bg=colour238] '
			set-window-option -g window-status-current-format '#[bg=colour236]#[fg=colour215] #I #[bg=colour235]#[fg=colour167] #[bg=colour234]#W#[bg=colour235]#[fg=colour195]#F#[bg=colour236] '

			# Pane Border Styling
			set-option -g pane-active-border-style fg=colour246
			set-option -g pane-border-style fg=colour238

			# Vim style pane selection
			bind h select-pane -L
			bind j select-pane -D
			bind k select-pane -U
			bind l select-pane -R

			# Kill fast
			bind K confirm kill-server

			# Enable focus-events
			set-option -g focus-events on

			# Toggle mouse mode
			bind C-m set -g mouse \; display 'Mouse #{?mouse,on,off}'
			bind ^m set -g mouse \; display 'Mouse #{?mouse,on,off}'
		'';

		plugins = [
			pkgs.tmuxPlugins.logging
			{
				plugin = pkgs.tmuxPlugins.resurrect;
				extraConfig = ''
					set -g @resurrect-dir '${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
				'';
			}
		];

	};
}
