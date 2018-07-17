#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Gnome"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo apt install gnome-terminal gnome-themes-extra eog evince dconf-cli

(
	cd $DIR
	dconf load / < dconf.ini 
)
