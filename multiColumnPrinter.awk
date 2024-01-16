# mc: multi-column printer

{ lines[NR] = $0
  if (length($0) > max)
    max = length($0)
}
END {
  fmt = sprintf("%%-%d.%ds,", max, max) # make a format string
  ncol = int(60/(max+2) + 0.5) # int(x) returns integer value of x
  for (i = 1; i <= NR; i += ncol) {
    out = ""
    for (j = i; j < i+ncol && j <= NR; j++)
      out = out sprintf(fmt, lines[j]) "  "
    sub(/ +$/, "", out)  # remove trailing spaces
    print substr(out, 1, length(out) - 1)
  }
}