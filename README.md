# Advent of Code 2021

A repository for my solutions to the 2021 Advent of Code coding challenge.

Because I have chosen to do these as pure `Bash/Awk`, there really isn't going to be much code here.

---
## Day 1 (Dec 1)
### Challenge 1

```bash
 awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' <<< $(cat aoc-input-1 | tr '\n' ' ') | wc -l
```

Not elegant, but it works. And it's FAST:

```bash
 time awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' <<< $(cat aoc-input-1 | tr '\n' ' ') | wc -l
    1722
    awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' <<<   0.01s user 0.01s system 105% cpu 0.014 total
    wc -l  0.00s user 0.00s system 27% cpu 0.014 total
```

I doubt many of the more "elegant" solutions are faster; I'd wager most are slower

### Challenge 2

```bash
awk '{for (i=3;i<=NF;i++) { printf("%d ", ($i + $(i-1) + $(i-2) ) ) }  }' <<< $(cat aoc-input-1 | tr '\n' ' ') | awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' | wc -l
```

```bash
 time awk '{for (i=3;i<=NF;i++) { printf("%d ", ($i + $(i-1) + $(i-2) ) ) }  }' <<< $(cat aoc-input-1 | tr '\n' ' ') | awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }' | wc -l
    1748
awk '{for (i=3;i<=NF;i++) { printf("%d ", ($i + $(i-1) + $(i-2) ) ) }  }' <<<  0.01s user 0.01s system 105% cpu 0.016 total
awk '{for (i=2;i<=NF;i++) {if ($i > $(i-1)) print "increase" } }'  0.00s user 0.00s system 32% cpu 0.017 total
wc -l  0.00s user 0.00s system 21% cpu 0.016 total
```

Might have been faster without the "here string", but I'm not sure the difference is measurable.

---

## Day 2 (Dec 2)
### Challenge 1

```bash
awk ' {if ($1 == "forward") H = (H + $2); if ($1 == "up") D = (D - $2); if ($1 == "down") D = (D + $2); printf("%s => H=%d D=%d T=%d\n", $0, H, D, H * D) }' aoc-input-2
```

No more here string....

> awk  aoc-input-2  0.01s user 0.00s system 87% cpu 0.010 total

still fast, too :D

### Challenge 2

```bash
awk ' {if ($1 == "forward") {H = (H + $2); D = (D + (A * $2))} if ($1 == "up") A = (A - $2); if ($1 == "down") A = (A + $2); printf("%s => H=%d D=%d T=%d\n", $0, H, D, H * D) }' aoc-input-2
```
> awk  aoc-input-2  0.00s user 0.00s system 85% cpu 0.008 total

---
## Day 3 (Dec 3)
### Challenge 1

I got complaints that my code is too unreadable. So I broke it into a multiline script for readability.

```bash
awk '\
  {\
    for (i=length($1);i>=1;i--)\
      {\
        if (substr($1, i, 1) == "1") \
          ONE[i]++; \
        else \
          ZERO[i]++;\
        if (ONE[i] > ZERO[i]) \
          {\
            G[i]=1;\
            E[i]=0\
          } \
        else \
          {\
            G[i]=0;\
            E[i]=1\
          } \
        }; \
        gamma=0; \
        eps=0; \
        pow=0; \
        for (i=length($1);i>=0;i--) \
          {\
            printf("%d = %d || %d = %d\n", G[i], 2^pow, E[i], 2^pow); \
            if (G[i]) gamma+=2^pow; \
            if (E[i]) eps+=2^pow; \
            pow++ \
          };\
          printf("G=%d E=%d R=%d\n", gamma, eps, gamma*eps) \
        }'\
        aoc-input-3
```

A lot more involved, but still under a tenth of a second...

> awk  aoc-input-3  0.07s user 0.01s system 96% cpu 0.085 total

### Challenge 2

Trying to run this directly as a command-line script proved cumbersome. I wound up resorting to using gawk for the "true" multidimensional arrays.  I also switched to using a file for input.

Once I got the logic right, it's still super fast:

```
time gawk -f aoc-3.awk aoc-input-3
reading data
........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................done
pass 1: 1000 to start
 pass 2: 528 to start
 pass 3: 268 to start
 pass 4: 136 to start
 pass 5: 75 to start
 pass 6: 45 to start
 pass 7: 24 to start
 pass 8: 14 to start
 pass 9: 10 to start
 pass 10: 7 to start
 pass 11: 4 to start
 pass 12: 2 to start
 011001100111
pass 1: 1000 to start
 pass 2: 472 to start
 pass 3: 219 to start
 pass 4: 96 to start
 pass 5: 44 to start
 pass 6: 21 to start
 pass 7: 10 to start
 pass 8: 2 to start
 101010000100
1 = 1 | 1 | 0 = 0
1 = 3 | 2 | 0 = 0
1 = 7 | 4 | 1 = 4
0 = 7 | 8 | 0 = 4
0 = 7 | 16 | 0 = 4
1 = 39 | 32 | 0 = 4
1 = 103 | 64 | 0 = 4
0 = 103 | 128 | 1 = 132
0 = 103 | 256 | 0 = 132
1 = 615 | 512 | 1 = 644
1 = 1639 | 1024 | 0 = 644
0 = 1639 | 2048 | 1 = 2692
oxy=1639 co=2692 lsr=4412188
gawk -f aoc-3.awk aoc-input-3  0.01s user 0.00s system 74% cpu 0.016 total
```

## Day 4
### Challenge 1

After Day 3, this didn't seem as hard. Maybe I am just leveling up....

```
 gawk -f aoc-4-1.awk aoc-input-4                                    AWS core ENV  INSERT   master  +1 U3
 27
 14
 70
 7
 85
 66
 65
 57
 68
 23
 33
 78
 4
 84
 25
 18
 43
 71
 76
 61
 34
 82
 93
 74
 BINGO card= 55
 XX XX  5 69 XX
 XX 60 40 73  6
 XX 54 67 32 38
 XX 62 17 51 86
 XX 88 99  3 16
 card score = 64084
 ```

 finally cracked 0.1 seconds:
 > gawk -f aoc-4-1.awk aoc-input-4  0.03s user 0.00s system 87% cpu 0.041 total

