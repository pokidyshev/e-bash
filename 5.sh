#!/bin/bash

# 5. Применение функций Bash

# (*) Лог /var/log/messages при необходимости высылается
#
# Придумать некую функцию, которая принимает параметры и делает некоторые
# действия (например, считает числа фибоначчи по номеру). Далее эта функция
# вызывается с параметрами, переданными в командной строки. Должна присутствовать
# проверка на количество передаваемых параметров, а также обработка ключа -h. При
# передаче этого ключа или передаче некорректных параметров должно выводиться
# сообщение о том, что принимает этот скрипт в качестве параметров. Примерно в
# таком виде (пример для команды df):
#
# [root@jenkins ~]# df --help
# Usage: df [OPTION]... [FILE]...
# Show information about the file system on which each FILE resides,
# or all file systems by default.

USAGE="Usage: $0 [--help] a b"
INFO="Find greater common divisor of a and b."

if [[ $# != 2 ]]; then
  echo $USAGE
  echo
  echo $INFO
  exit 0
fi

function gcd {
  dividend=$1
  divisor=$2
  remainder=1

  until [[ $remainder == 0 ]]; do
    let "remainder = $dividend % $divisor"
    dividend=$divisor
    divisor=$remainder
  done

  echo $dividend
}

gcd $1 $2
