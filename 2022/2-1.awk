BEGIN {
  score = 0;
  rock = 1;
  paper = 2;
  scissors = 3;
  win = 6;
  draw = 3;
}
{
  if ($1 == "A") {
    if ($2 == "Y") score += win;
    if ($2 == "X") score += draw;
  }
  if ($1 == "B") {
    if ($2 == "Z") score += win;
    if ($2 == "Y") score += draw;
  }
  if ($1 == "C") {
    if ($2 == "X") score += win;
    if ($2 == "Z") score += draw;
  }
  if ($2 == "X") score += rock;
  if ($2 == "Y") score += paper;
  if ($2 == "Z") score += scissors;
}
END {
  printf("final score: %s\n", score)
}

