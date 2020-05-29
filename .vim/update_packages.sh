#!/bin/bash
source paths.sh

# Clone any new packages
IFS=$'\n'
cd $PACKDIR/start
while read url; do
  if [ ! -d `basename $url .git` ]
  then
    git clone $url
  fi
done < $ROOT/packages.list
cd -

for dir in $PACKDIR/start $PACKDIR/opt; do
  cd $dir

  for i in `ls`; do
    echo -n "$(basename $i): "
    cd "$i"

    git pull | grep --color=never -oE '^Already up to date|^From .*'

    cd ..
  done
done
