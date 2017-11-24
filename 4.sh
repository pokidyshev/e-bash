#!/bin/bash

# 4. Применение AWK для обработки текста, LaTeX для верстки.

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

USAGE="usage: $0 [--help]"
INFO="Вывести список usb-устройств, сгруппированных по idVendor, в pdf."

if [[ $# > 0 ]]; then
  echo $USAGE; echo; echo $INFO; exit 0
fi

gawk -f 4.awk dmesg_usb | pdflatex

rm -f texput.log texput.aux
