  BEGIN {
    len=0
    print "reading data " ;
  };
  {
    if (len < length($1)) len=length($1);
    printf(".", "");
    IN[NR] = $1;
  }
  END {
    print "done";
    for (i=1;i<=FNR;i++) cand[1][i]=IN[i];
    k=1;
    for (j=1;j<=len;j++) {
      printf("pass %d: %d to start\n ", j, length(cand[j]));
      ONE[j] = 0;
      ZERO[j] = 0;
      for (i in cand[j])  {
        c = cand[j][i];
        if (substr(c, j, 1) == "1") ONE[j]++;
        else ZERO[j]++;
        };
      for (i in cand[j]) {
        c = cand[j][i];
        if (ONE[j] > ZERO[j]) {
          if (substr(c, j, 1) == 1) {
            cand[j+1][i] = c;
          };
        }
        else if (ONE[j] < ZERO[j]) {
          if (substr(c, j, 1) == 0) {
            cand[j+1][i] = c;
          };
        }
        else if (ONE[j] == ZERO[j]) {
          if (substr(c,j,1) == 1) {
            cand[j+1][i] = c;
          };
        };
      };
      k=j+1;
      if (length(cand[k]) == 1) {
        for (i in cand[k]) {
          if (cand[k][i]) obits = cand[k][i];
        }
        break;
      }
    };
    print obits;
    k = 1;
    for (i in cand) delete cand[i];
    for (i=1;i<=FNR;i++) cand[k][i]=IN[i];
    for (j=1;j<=len;j++) {
      printf("pass %d: %d to start\n ", j, length(cand[j]));
      ONE[j] = 0;
      ZERO[j] = 0;
      for (i in cand[j])  {
        c = cand[j][i];
        if (substr(c, j, 1) == "1") ONE[j]++;
        else ZERO[j]++;
        };
      for (i in cand[j]) {
        c = cand[j][i];
        if (ONE[j] > ZERO[j]) {
          if (substr(c,j,1)==0) {
            cand[j+1][i] = c;
          };
        }
        else if (ONE[j] < ZERO[j]) {
          if (substr(c,j,1)==1) {
            cand[j+1][i] = c;
          };
        }
        else if (ONE[j] = ZERO[j]) {
          if (substr(c,j,1)==0) {
            cand[j+1][i] = c;
          };
        };
      };
      k++;
      if (length(cand[k]) == 1) {
        for (i in cand[k]) {
          if (cand[k][i]) cbits = cand[k][i];
        }
        break;
      }
    };
    print cbits;
    oxy=0;
    co=0;
    pow=0;
    lsr=0;
    for (i=length(obits);i>0;i--)
      {
        if (substr(obits,i,1) == 1) oxy+=2^pow;
        if (substr(cbits,i,1) == 1) co+=2^pow;
        printf("%d = %d | %d | %d = %d\n", substr(obits,i,1), oxy,  2^pow, substr(cbits,i,1), co);
        pow++
      };
      printf("oxy=%d co=%d lsr=%d\n", oxy, co, oxy*co)
    }
