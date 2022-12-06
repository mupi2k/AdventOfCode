BEGIN {
  start = 4
  lines = 1
}
{
  for (i=start+1; i<=length($0); i++) {
    possible = substr($0,i-start, start)
    found = ""
    for (n=1;n<=start;n++) {
      jinx = substr(possible, n+1, start - n)
      char = substr(possible, n, 1)
      if (jinx ~ substr(possible, n, 1) )
        found = 1
    }
    if (found != 1) {
      print (i-1)
      break
    }
  }
}

