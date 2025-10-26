#!/usr/bin/env bash

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
if grep "Name" "/etc/os-release" | grep "NixOS"; then
	sudo nixos-rebuild switch
fi
