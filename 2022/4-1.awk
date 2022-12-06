BEGIN {
  lines = 0
  contained = 0
  }
  {
    lines++
    split($1,one,"-")
    split($2,two,"-")
    if ((one[1] == two[1]) || (one[2] == two[2])) contained++
    else if (one[1] < two[1] ) {
      if (two[2] <= one[2]) contained++
    }
    else if (one[2] <= two[2]) contained++
    else printf("%5d : %s = no match\n", lines, $0)
  }
  END {
    printf("%s contained in %s lines", contained, lines)
  }
