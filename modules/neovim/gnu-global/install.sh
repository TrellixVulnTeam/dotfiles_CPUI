#!/bin/bash

echo ""
echo "========================================"
echo "Installing GNU GLOBAL"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
VERSION="6.6.2"
ARCHIVE_FILE_NAME="global-$VERSION.tar.gz"
SOURCE_DIR_NAME="global-$VERSION"

sudo apt install gcc g++ autoconf automake make libncurses5-dev

(
	cd $DIR
	$DIR/bundle.sh
	tar xf $ARCHIVE_FILE_NAME
	cd $DIR/$SOURCE_DIR_NAME

	./configure
	make
	sudo make install

	ln -s -f $DIR/globalrc $HOME/.globalrc
	sudo sed -i '1s/python$/python2/' /usr/local/share/gtags/script/pygments_parser.py
	echo ""
	echo "Remember to set GTAGSLABEL=pygments in your shell startup file"
	echo " (The Zsh module already includes this configuration)"
)
