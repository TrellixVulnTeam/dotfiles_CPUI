#!/bin/bash

echo ""
echo "========================================"
echo "Bundling neovim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

(
	cd $DIR
	mkdir $DIR/plugins
	for PLUGIN in $(grep -E "^call dein#add" $DIR/init.vim | sed -E "s/call dein#add\('(.*)'[,)].*/\1/"); do
		if [ ! -e "$DIR/plugins/$PLUGIN" ]; then
			git clone --recursive "https://github.com/$PLUGIN" "$DIR/plugins/$PLUGIN"
		fi
	done

	$DIR/gnu-global/bundle.sh
)
