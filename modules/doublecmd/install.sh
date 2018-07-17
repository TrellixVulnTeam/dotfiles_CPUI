#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Double Commander"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="$HOME/.config/doublecmd"

sudo apt install doublecmd-gtk

(
	cd $DIR
	mkdir -p $TODIR
	cp $DIR/doublecmd.xml $TODIR/doublecmd.xml
)
