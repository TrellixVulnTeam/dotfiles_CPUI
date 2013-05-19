#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

echo ""
echo "========================================"
echo "Configuring vim"
echo "========================================"

ln -sf $DIR/vimrc $HOME/.vimrc
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
mkdir $HOME/.vim/colors
cp $DIR/obsidian.vim $HOME/.vim/colors/obsidian.vim
vim +BundleInstall +qall
