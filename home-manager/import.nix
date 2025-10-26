# { config, pkgs, lib, ... }:
# let
#   b = builtins;                                      # short alias for builtins
#   module_files = ./modules/ |>                      # assign the result of the pipe to module_files, & pass ../modules/ to the function on the next line
#     b.readDir |>                                     # returns an attribute set, names are files, values their type
#     b.attrNames |>                                   # gets the names of the attribute set, the files
#     b.filter (f: lib.strings.hasSuffix ".nix" f) |>  # keep only files that end in ".nix"
#     b.map (e: ./modules/${e});                      # for each file prepend the path to the directory
# in
# {
#   imports = module_files
# }
{ config, pkgs, lib, ... }:
{
	imports = [
		./modules/zsh.nix
		./modules/git.nix
		./modules/tmux.nix
		./modules/kitty.nix
	]
}
