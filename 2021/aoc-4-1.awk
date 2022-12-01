# vim: ai et ts=2 sw=2
BEGIN {
  cardNum = 0;
  FS = ",";
}
{
  if (NR == 1) {
    for (i=1;i<=NF;i++) call[i]=$i;
    FS = " "
  }
  else if ($0 == "") {
    cardNum++
    cardRow = 1
    cardCol = 1
  }
  else {
    for (i=1;i<=NF;i++) card[cardNum][cardRow][i] = $i;
    cardRow++
    }
}
END{
  for (n in call) {
    for (c in card) {
      for (r in card[c]) {
        for (i=1;i<=length(card[c][r]);i++) {
          if (card[c][r][i] == call[n]) mark[c][r][i] = "X";
        }
      }
    }
    print call[n]
    for (c in card) {
      for (r in card[c]) {
        if ((mark[c][r][1] && mark[c][r][2] && mark[c][r][3] && mark[c][r][4] && mark[c][r][5]) || (mark[c][1][r] && mark[c][2][r] && mark[c][3][r] && mark[c][4][r] && mark[c][5][r])) {
          print "BINGO card= " c
          bingo = c
          break
        }
        if (bingo) break;
      }
      if (bingo) break;
    }
    if (bingo) break;
  }
  for (r in card[bingo]) {
    for (i=1;i<=length(card[bingo][r]);i++) {
      if (mark[bingo][r][i]) printf("XX ")
      else {
        printf("%2s ", card[bingo][r][i])
        sum += card[bingo][r][i]
      }
    }
    print ""
  }
  print "card score = " sum*call[n]
}
