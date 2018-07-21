#!/bin/bash

echo ""
echo "========================================"
echo "Bundling GNU GLOBAL"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
VERSION="6.6.2"
ARCHIVE_FILE_NAME="global-$VERSION.tar.gz"

if [ ! -e "$DIR/$ARCHIVE_FILE_NAME" ]; then
	wget "https://www.tamacom.com/global/$ARCHIVE_FILE_NAME" -O $DIR/$ARCHIVE_FILE_NAME
fi
