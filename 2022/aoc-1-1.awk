BEGIN {
  cal = 0;
  };
{
    if ($0 == "") {
      printf("%s\n",cal);
      cal = 0;
    }
    else cal += $0;
}
END {
  printf("%s\n",cal)
}

