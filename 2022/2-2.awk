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
    if ($2 == "X") score += scissors;
    if ($2 == "Y") score += draw + rock;
    if ($2 == "Z") score += win + paper;
  }
  if ($1 == "B") {
    if ($2 == "X") score += rock;
    if ($2 == "Y") score += draw + paper;
    if ($2 == "Z") score += win + scissors;
  }
  if ($1 == "C") {
    if ($2 == "X") score += paper;
    if ($2 == "Y") score += draw + scissors;
    if ($2 == "Z") score += win + rock;
  }
}
END {
  printf("final score: %s\n", score)
}

