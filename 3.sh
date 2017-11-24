#!/bin/bash

# 3. Парсинг текста регулярными выражениями и простыми утилитами
# (grep, wc, tr, cut, uniq, sort, echo, cat)

# 7. Используя вывод команды dmesg, вывести список usb-устройств,
# сгруппированных по idVendor, в формате (пример):
#
# idVendor : AAA
# total: 2
# usb1: 0000:00:12.1
# usb2: 0000:00:12.2
#
# idVendor : BBB
# total: 3
# usb1: 0000:00:13.1
# usb2: 0000:00:13.2
# usb3: 0000:00:13.3

USAGE="Usage: $0 [--help]"
INFO="Вывести список usb-устройств, сгруппированных по idVendor"

if [[ $# > 1 ]] || [[ $1 == '--help' ]]; then
  echo $USAGE
  echo
  echo $INFO
  exit 0
fi

rm -f dmesg_usb

grep usb dmesg | grep idVendor | while read -r i; do
  number="$(echo $i | cut -d '[' -f2 | cut -d ']' -f1)"
  vendor="$(echo $i | cut -d '=' -f2 | cut -d ',' -f1)"
  name="$(echo $i | cut -d ' ' -f4)"
  echo "$vendor $name $number" >> dmesg_usb
done

for vendor in `cut -d ' ' -f1 dmesg_usb | uniq`; do
  echo
  echo "idVendor: $vendor"
  echo "total: $(grep "$vendor" dmesg_usb | wc -l | sed -e 's/^[ \t]*//')"
  grep "$vendor" dmesg_usb | cut -d ' ' -f2,4
done
