#!/bin/bash

set -e

source paths.sh

# Make directories which vimrc expects to exist
mkdir -p $ROOT/tmp
mkdir -p $ROOT/undo

# Make a directory for startup packages
mkdir -p $PACKDIR/start
cd $PACKDIR/start

# Install startup packages
IFS=$'\n'
while read url; do
  git clone $url
done < $ROOT/packages.list

# Make a directory for optional packages
mkdir -p $PACKDIR/opt
cd $PACKDIR/opt

# Install optional packages
git clone https://github.com/JamshedVesuna/vim-markdown-preview.git

echo
echo "Also make sure to install (g)vim (8.0+) itself, as well as these dependencies:"
echo "* DejaVu Sans Mono (https://dejavu-fonts.github.io/)"
echo "* ag (https://github.com/ggreer/the_silver_searcher)"
echo
read -p "Press ENTER to try installing everything automatically based on your OS..."
echo

unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
  set -x
  sudo apt-get install vim-gtk3 fonts-dejavu silversearcher-ag libxml2-utils
  set +x
elif [ "$unamestr" = 'Darwin' ]; then
  set -x
  brew install homebrew/cask/macvim
  brew install the_silver_searcher libxml2

  # DejaVu Sans Mono
  brew install homebrew/cask-fonts/font-dejavu
  set +x
fi
