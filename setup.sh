#!/bin/bash

source paths.sh

# Make directories which vimrc expects to exist
mkdir -p $ROOT/tmp
mkdir -p $ROOT/undo

# Make a directory for startup packages
mkdir -p $PACKDIR/start
cd $PACKDIR/start

# Install startup packages
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/dyng/ctrlsf.vim.git
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/haya14busa/vim-asterisk.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/morhetz/gruvbox.git
git clone https://github.com/ntpeters/vim-better-whitespace.git
git clone https://github.com/qpkorr/vim-renamer.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/tpope/vim-characterize
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tpope/vim-sleuth.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/tpope/vim-vinegar.git
git clone https://github.com/w0rp/ale.git
git clone https://github.com/will133/vim-dirdiff.git

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
  brew install vim the_silver_searcher libxml2
  brew cask install macvim

  # DejaVu Sans Mono
  brew tap caskroom/fonts
  brew cask install font-dejavu-sans
  set +x
fi
