# Advent of Code 2021

A repository for my solutions to the 2021 Advent of Code coding challenge.

Because I have chosen to do these as pure `Bash/Awk`, there really isn't going to be much code here.

## Day 1 (Dec 1)
### Challenge 1

` awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' <<< $(cat aoc-input-1 | tr '\n' ' ') | wc -l `

Not elegant, but it works. And it's FAST:

> time awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' <<< $(cat aoc-input-1 | tr '\n' ' ') | wc -l\n
    1722\n
    awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' <<<   0.01s user 0.01s system 105% cpu 0.014 total
    wc -l  0.00s user 0.00s system 27% cpu 0.014 total

I doubt many of the more "elegant" solutions are faster; I'd wager most are slower

### Challenge 2

`awk '{for (i=3;i<=NF;i++) { printf("%d ", ($i + $(i-1) + $(i-2) ) ) }  }' <<< $(cat aoc-input-1 | tr '\n' ' ') | awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' | wc -l`

> time awk '{for (i=3;i<=NF;i++) { printf("%d ", ($i + $(i-1) + $(i-2) ) ) }  }' <<< $(cat aoc-input-1 | tr '\n' ' ') | awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' | wc -l
    1748
awk '{for (i=3;i<=NF;i++) { printf("%d ", ($i + $(i-1) + $(i-2) ) ) }  }' <<<  0.01s user 0.01s system 105% cpu 0.016 total
awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }'  0.00s user 0.00s system 32% cpu 0.017 total
wc -l  0.00s user 0.00s system 21% cpu 0.016 total

Might have been faster without the "here string", but I'm not sure the difference is measurable.

## Day 2 (Dec 2)
### Challenge 1

`awk ' {if ($1 == "forward") {H = (H + $2); D = (D + (A * $2))} if ($1 == "up") A = (A - $2); if ($1 == "down") A = (A + $2); printf("%s => H=%d D=%d T=%d\n", $0, H, D, H * D) }' aoc-input-2`

No more here string....

> awk  aoc-input-2  0.01s user 0.00s system 87% cpu 0.010 total

still fast, too :D

### Challenge 2

`awk ' {if ($1 == "forward") {H = (H + $2); D = (D + (A * $2))} if ($1 == "up") A = (A - $2); if ($1 == "down") A = (A + $2); printf("%s => H=%d D=%d T=%d\n", $0, H, D, H * D) }' aoc-input-2`

> awk  aoc-input-2  0.00s user 0.00s system 85% cpu 0.008 total


