#!/bin/bash

echo ""
echo "========================================"
echo "Configuring neovim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
VERSION="0.3.1"

sudo apt remove vim
sudo apt autoremove
sudo apt install clang xsel xclip

$DIR/bundle.sh

(
	cd $DIR/neovim-$VERSION
	sudo make install
)

pip3 install --user -U neovim mypy pycodestyle grip autopep8 yapf --no-index -f $DIR/pip
pip2 install --user -U neovim Pygments --no-index -f $DIR/pip
sudo cp -r $DIR/npm/node_modules /usr/local/lib/
for BIN_LINK in $(ls /usr/local/lib/node_modules/.bin); do
	sudo ln -s -f $(readlink -f /usr/local/lib/node_modules/.bin/$BIN_LINK) /usr/local/bin/$BIN_LINK
done

sudo ln -s $(which nvim) /usr/local/bin/vim

export PATH="$HOME/.local/bin:$PATH"

(
	cd $DIR
	mkdir -p $HOME/.config/nvim
	ln -s -f $DIR/init.vim $HOME/.config/nvim/init.vim

	mkdir -p $HOME/.config/nvim/dein/repos/github.com
	cp -r $DIR/plugins/* $HOME/.config/nvim/dein/repos/github.com/

	mkdir -p $HOME/.config/nvim/colors
	ln -s -f $DIR/colosus.vim $HOME/.config/nvim/colors/
	ln -s -f $DIR/mypy.ini $HOME/.mypy.ini

	ln -s -f $DIR/ctags.conf $HOME/.ctags
	$DIR/gnu-global/install.sh

	mkdir -p $HOME/.config/nvim/plugin
	ln -s -f /usr/local/share/gtags/gtags-cscope.vim $HOME/.config/nvim/plugin/
	ln -s -f /usr/local/share/gtags/gtags.vim $HOME/.config/nvim/plugin/

	nvim -c "UpdateRemotePlugins" -c "call dein#recache_runtimepath()" -c "exit"
)
