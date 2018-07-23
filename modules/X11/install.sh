#!/bin/bash

echo ""
echo "========================================"
echo "Configuring X11"
echo "Keyboard and Monitors"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo apt install xserver-xorg xinit x11-utils x11-xserver-utils

(
	TODIR="/etc/X11/xorg.conf.d/"
	cd $DIR
	sudo mkdir -p $TODIR
	for confFile in *.conf; do
		sudo ln -s -f $DIR/$confFile $TODIR
	done
	ln -s -f $DIR/xinitrc $HOME/.xinitrc
)
