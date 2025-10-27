{
	pkgs,
	config,
	lib,
	...
}: let
	cfg = config.myHomeManager;
in {
	programs.kitty = {
		enable = true;
		settings = {
			font_size = "14.0";
			font_family = "monospace";
			bold_font = "auto";
			italic_font = "auto";
			bold_italic_font = "auto";
			copy_on_select = "yes";
			macos_option_as_alt = "yes";
		};
	};
}

