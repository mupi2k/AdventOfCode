BEGIN {
  need = 30000000
  avail = 0
  min_free = 0
  total = 70000000
}
{
  if ($1 == "/:") {
    printf("used: %d \n",$2)
    avail = total - $2
    min_free = need - avail
    printf("avail: %d \nNeed: %d\n", avail, min_free)
  }
  if ($2 > min_free) {
    print
  }
}
