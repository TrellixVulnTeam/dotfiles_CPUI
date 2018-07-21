#!/bin/bash

echo ""
echo "========================================"
echo "Configuring neovim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo apt remove vim
sudo apt install neovim clang xsel xclip
sudo apt remove python-neovim python3-neovim
sudo apt autoremove
pip install --user -U neovim mypy pycodestyle grip autopep8 yapf
pip2 install --user -U neovim
sudo npm install -g neovim typescript tern tslint
sudo ln -s $(which nvim) /usr/local/bin/vim

export PATH="$HOME/.local/bin:$PATH"

(
	cd $DIR
	mkdir -p $HOME/.config/nvim
	ln -s $DIR/init.vim $HOME/.config/nvim/init.vim

	$DIR/bundle.sh
	mkdir -p $HOME/.config/nvim/dein/repos/github.com
	cp -r $DIR/plugins/ $HOME/.config/nvim/dein/repos/github.com/

	mkdir -p $HOME/.config/nvim/colors
	ln -s -f $DIR/colosus.vim $HOME/.config/nvim/colors/
	ln -s -f $DIR/mypy.ini $HOME/.mypy.ini

	ln -s -f $DIR/ctags.conf $HOME/.ctags
	$DIR/gnu-global/install.sh

	mkdir -p $HOME/.config/nvim/plugin
	ln -s -f /usr/local/share/vim/vimfiles/plugin/gtags-cscope.vim $HOME/.config/nvim/plugin/
	ln -s -f /usr/local/share/vim/vimfiles/plugin/gtags.vim $HOME/.config/nvim/plugin/

	nvim -c "call dein#install()" -c "exit"
)
