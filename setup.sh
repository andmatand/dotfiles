#!/bin/sh

ln -s $PWD/.zshrc $HOME
ln -s $PWD/.zshenv $HOME
ln -s $PWD/.zsh_aliases $HOME
ln -s $PWD/.vim $HOME

cd .vim
./setup.sh
