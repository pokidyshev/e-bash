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

USAGE="Usage: $0 [--help]"
INFO="вывести список usb-устройств, сгруппированных по idVendor в pdf"

if [[ $# > 0 ]]; then
  echo $USAGE
  echo
  echo $INFO
  exit 0
fi

grep usb dmesg.txt | grep idVendor | while read -r i; do
  number="$(echo $i | cut -d '[' -f2 | cut -d ']' -f1)"
  vendor="$(echo $i | cut -d '=' -f2 | cut -d ',' -f1)"
  name="$(echo $i | cut -d ' ' -f4)"
  echo "$vendor $name $number" >> temp_usb.txt
done

TEX='BEGIN{
  print "\\documentclass{article}\\begin{document}\\begin{tabular}{cc}"} {printf "%s & %s\\\\\n", $1, $2} END{ print "\\end{tabular}\\end{document}" }'

for vendor in `cut -d ' ' -f1 temp_usb.txt | uniq`; do
  echo
  echo "idVendor: $vendor"
  echo "total: $(grep "$vendor" temp_usb.txt | wc -l | sed -e 's/^[ \t]*//')"
  grep "$vendor" temp_usb.txt \
    | cut -d ' ' -f2,4 \
    | awk  \
    | pdflatex --jobname table --
done

rm -f temp_usb.txt
