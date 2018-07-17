#!/bin/bash

echo ""
echo "========================================"
echo "Installing GNU GLOBAL"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TMP_DIR="/tmp/global"
NAME="global"
VERSION="6.6.2"
DIR_NAME="$NAME-$VERSION"
TAR_NAME="$DIR_NAME.tar.gz"

sudo apt install autoconf automake make libncurses5-dev

(
	mkdir $TMP_DIR
	cd $TMP_DIR
	wget "http://tamacom.com/global/$TAR_NAME"
	tar xf $TAR_NAME
	cd $DIR_NAME
	./configure
	make 
	sudo make install
	sudo pip2 install Pygments

	ln -s -f $DIR/globalrc $HOME/.globalrc
	sudo sed -i '1s/python$/python2/' /usr/local/share/gtags/script/pygments_parser.py
	echo ""
	echo "Remember to set GTAGSLABEL=pygments in your shell startup file"
	echo " (The Zsh module already includes this configuration)"
)
