#!/bin/sh

set -e

ln -fs $PWD/.zshrc $HOME
ln -fs $PWD/.zshenv $HOME
ln -fs $PWD/.zsh_aliases $HOME
ln -fs $PWD/.vim $HOME

cd .vim
./setup.sh
