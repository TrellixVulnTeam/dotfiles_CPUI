#!/bin/bash

echo ""
echo "========================================"
echo "Bundling neovim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo apt install python3-pip python3-setuptools python-setuptools python-pip npm

(
	cd $DIR
	mkdir $DIR/plugins
	for PLUGIN in $(grep -E "^call dein#add" $DIR/init.vim | sed -E "s/call dein#add\('(.*)'[,)].*/\1/"); do
		if [ ! -e "$DIR/plugins/$PLUGIN" ]; then
			git clone --recursive "https://github.com/$PLUGIN" "$DIR/plugins/$PLUGIN"
			if [ -e "$DIR/plugins/$PLUGIN/install.sh" ]; then
				(
					cd $DIR/plugins/$PLUGIN
					./install.sh
				)
			fi
		fi
	done

	if [ ! -e "$DIR/pip" ]; then
		mkdir $DIR/pip
		pip3 download -d $DIR/pip neovim mypy pycodestyle grip autopep8 yapf
		pip2 download -d $DIR/pip neovim Pygments
	fi

	if [ ! -e "$DIR/npm" ]; then
		mkdir $DIR/npm
		(
			cd $DIR/npm
			npm install neovim typescript tern tslint
		)
	fi

	$DIR/gnu-global/bundle.sh
)
