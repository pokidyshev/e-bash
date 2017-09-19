#!/bin/bash

# Номер 6
# Найти в директории файлы, которые были созданы ранее
# чем указанный в параметрах файл F.
# F передается параметром

USAGE="Usage: $0 [--help] filepath"
INFO="Найти в директории файлы, которые были созданы ранее
чем указанный в параметрах файл"

if [[ $# < 1 ]] || [[ $1 == '--help' ]]; then
  echo $USAGE
  echo
  echo $INFO
  exit 0
fi

target_bd=`stat -f "%m" $1`

for i in `find . -type f`; do
  bd=`stat -f "%m" $i`
  if [[ $bd < $target_bd ]]; then
    echo $i
  fi
done
