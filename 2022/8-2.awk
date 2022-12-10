function hidden(curr, x, y, locx, hid_l, hid_r, hid_u, hid_d) {
  hid_l = 0
  hid_r = 0
  hid_u = 0
  hid_d = 0
  down = 0
  up = 0
  left = 0
  right = 0
  for (locx=x+1; locx<=NR; locx++) {
    if (!hid_d) down++
    if (curr <= grid[locx,y])
      hid_d = 1
  }
  for (locx=x-1; locx>=1; locx--) {
    if (!hid_u) up++
    if (curr <= grid[locx,y])
      hid_u = 1
  }
  for (locy=y+1; locy<=maxlength; locy++) {
    if (!hid_r) right++
    if (curr <= grid[x,locy])
      hid_r = 1
  }
  for (locy=y-1; locy>=1; locy--) {
    if (!hid_l) left++
    if (curr <= grid[x,locy])
      hid_l = 1
  }
  score[x,y] = (up * left * right * down)
  if (hid_u && hid_d && hid_r && hid_l) return 1
  else return 0
    }

BEGIN {
  lines = 0
  grid[0] = ""
  vis[0] = ""
  maxlength = 0
}
{
  lines++
  if (length($0) > maxlength) maxlength = length($0)
  for (i=1;i<=length($0);i++) {
    sq = substr($0, i, 1)
    grid[NR,i] = sq
  }
}
END {
  printf("%d lines read\n",NR)
  delete grid[0]
  for (row=1;row<=NR;row++) {
    # first and last row are all visible:
    if (row == 1 || row == NR) {
      for (col=1;col<=maxlength;col++) {
        vis[row,col]= "V"
      }
    } else {
      for (col=1;col<=maxlength;col++) {
        if (col == 1 || col == maxlength) {
          #first and last in each row are always visible:
          vis[row,col]= "V"
        } else {
          current = grid[row,col]
          if (!hidden(current, row, col)) vis[row,col] = "V"
        }
      }
    }
  }
  delete vis[0]
  #for (cell in vis) {
  #  if (vis[cell] == "V") visible++
  #}
  max = 0
  for (cell in grid) {
       cells++
       if (vis[cell] == "V") visible++
       if (score[cell] > max) max = score[cell]
  }
  printf("%d visible in %d cells. Max score is %d\n", visible, cells, max )
}
