{
  total[$1]++;
  ids[$1][$2] = $3
}
END {
  printf "\\documentclass{article}\n"
  printf "\\begin{document}\n"

  for (vendor in total) {
      printf "\\bigskip idVendor: %s\n\n", vendor
      printf "total: %d\n\n", total[vendor]

      for (device in ids[vendor]) {
          printf "%s %s\n\n", device, ids[vendor][device]
      }
  }

  printf "\\end{document}\n"
}
