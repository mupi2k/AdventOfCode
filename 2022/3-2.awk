BEGIN {
  group = 0
}
{
  for (i=1; i<=length($1); i++) {
    c = substr($1,i,1)
    if (index($2, c) != 0)
      if (index($3, c) != 0) {
        common[group] = c
      }
    }
    group++
}
END {
  priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  for (group in common) {
    score = match(priorities, common[group])
    total += score
  }
  printf("total is: %s\n", total)
}



