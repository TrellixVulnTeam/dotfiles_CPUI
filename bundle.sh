#!/bin/bash
set -e

DOTFILES_MODULES=$(ls ./modules)

for MODULE in $DOTFILES_MODULES; do
	if [ -a ./modules/$MODULE/bundle.sh ]; then
		./modules/$MODULE/bundle.sh
	fi
done
