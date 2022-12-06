BEGIN {
  lines = 0
  overlap = 0
  }
  {
    lines++
    split($1,one,"-")
    split($2,two,"-")
    if ((one[1] == two[1]) || (one[2] == two[2])) overlap++
    else if ((one[1] > two[1]) && (one[1] <= two[2])) overlap++
    else if ((one[2] < two[2]) && (one[2] >= two[1])) overlap++
    else if ((two[1] > one[1]) && (two[1] <= one[2])) overlap++
    else if ((two[2] > one[2]) && (two[2] <= one[1])) overlap++
    else printf("%5d : %s = no match\n", lines, $0)
  }
  END {
    printf("%s overlap in %s lines", overlap, lines)
  }
