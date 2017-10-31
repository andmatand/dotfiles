#!/bin/bash
source paths.sh

for dir in $PACKDIR/start $PACKDIR/opt; do
  cd $dir

  for i in `ls`; do
    echo -n "$(basename $i): "
    cd "$i"

    git pull | grep --color=never -oE '^Already up to date|^From .*'

    cd ..
  done
done
