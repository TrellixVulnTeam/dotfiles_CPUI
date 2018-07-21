#!/bin/bash

echo ""
echo "========================================"
echo "Installing i3wm"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo apt install --install-recommends i3 feh autocutsel

(
	cd $DIR
	TODIR="$HOME/.config/i3/"
	mkdir -p $TODIR
	ln -s -f $DIR/config $TODIR/
	ln -s -f $DIR/i3status.conf $TODIR/
	ln -s -f $DIR/i3-session $TODIR/
)
