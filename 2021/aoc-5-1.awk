function rdraw(r, from, to) { if (from < to) {for (i=from;i<=to;i++) map[r][i]++ }
  else {for (i=from;i>=to;i--) map[r][i]++ }
}

function cdraw(col, from, to) {
  if (from < to) { for (i=from;i<=to;i++) map[i][col]++ }
  else { for (i=from;i>=to;i--) map[i][col]++ }
}

BEGIN {
  FS = "->"
}
{
  split($1, a, ",")
  split($2, b, ",")
  if (a[1] == b[1]) {
    rdraw(a[1]+1, a[2]+1, b[2]+1)
  }
  else if (a[2] == b[2] ) {
    cdraw(a[2]+1, a[1]+1, b[1]+1)
  }
  printf(".")
  if (a[1] > b[1]) {
    if ((a[1] + 1) > maxcol) {maxcol = a[1]}
  } else if ((b[1] + 1) > maxcol) {maxcol = b[1]}

  if (a[2] > b[2]) {
    if ((a[2] + 1) > maxrow) {maxrow = a[2] }
  }  else if ((b[2] + 1) > maxrow) {maxrow = b[2] }

}
END {
  danger = 0
  printf("\n")
  size = length(map)
  print("map size: ", size)
  for (row in map) {
    for (i=1;i<=size;i++) {
      if (map[row][i] > 1) {
        danger++
      }
    }
  }
  print danger
  danger = 0
  printf("\n")
  printf("map size: %s x %s\n", maxcol, maxrow)
  for (j=1;j<=maxrow;j++) {
    for (i=1;i<=maxcol;i++) {
        if (map[j][i] > 1) danger++;
    }
  }
  print danger
}

