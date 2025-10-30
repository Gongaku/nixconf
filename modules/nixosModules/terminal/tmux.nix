{
	flake.nixosModules.terminal = { pkgs, ... }: {
		programs.tmux = {
			enable = true;
			baseIndex = 1;
			terminal = "tmux-256color";
			aggressiveResize = true;
			escapeTime = 10;

			extraConfig = ''
				# Renumbers windows if one closes
				set -g renumber-windows on

				# Open new window/pane in current directory
				bind c new-window -c '#{pane_current_path}'
				bind '%' split-window -h -c '#{pane_current_path}'
				bind '"' split-window -v -c '#{pane_current_path}'

				# Set window notifications
				setw -g monitor-activity on
				set -g visual-activity on

				# Automatically set window title
				setw -g automatic-rename off
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

				# Use vim keybindings in copy mode
				setw -g mode-keys vi
				bind -T copy-mode-vi v send -X begin-selection
				bind -T copy-mode-vi V send -X rectangle-toggle
				bind P paste-buffer

				# Vim style pane selection
				bind h select-pane -L
				bind j select-pane -D
				bind k select-pane -U
				bind l select-pane -R

				# Kill fast
				bind K confirm kill-server

				# Enable focus-events
				set-option -g focus-events on

				#-----------------------------
				# Mouse Mode Settings
				#-----------------------------
				# Use mouse mode
				set -g mouse on

				# Toggle mouse mode
				bind C-m set -g mouse \; display 'Mouse #{?mouse,on,off}'
				bind ^m set -g mouse \; display 'Mouse #{?mouse,on,off}'
			'';
		};
	};
}
