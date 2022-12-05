BEGIN {
  lines = 0
}
{
  # find the midpoint:
  mid = length($0)/2
  # create a regexp character set from the contents of the first compartment
  f = "[" substr($0, 0, mid) "]"
  # second compartment:
  s = substr($0, mid+1)
  # use awks match() to find the item in both compartments:
  where = match(s, f)
  # in gawk:
  # match(s, f, c)
  # common[lines] = c[0]
  # because gawk allows you to pass an array to match; I don't need that here, but I might for a different challenge
  #
  c = substr(s, where, 1)
  common[lines] = c
  lines += 1
}
END {
  priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  for (line in common) {
    score = match(priorities, common[line])
    total += score
  }
  printf("total is: %s\n", total)
}



