# Advent of Code 2022

A repository for my solutions to the 2022 Advent of Code coding challenge.

Because I have chosen to do these as pure `Bash/Awk`, there really isn't going to be much code here.

As this is my second AoC, I've moved all of last year's stuff to `./2021/`; This year's challenges are starting off in `./2022`.
---
## Day 1 (Dec 1)
### Challenge 1

After last year, I realized that there is value in creating a `.awk` file with the awk code. Among other things, it's a heck of a lot easier to edit in vi/vim than straight CLI, even in vi/vim mode.

```bash
awk -f aoc-1-1.awk input-l | sort -n
```

I could do more of the work in the awk, but it's not complicated, and that's literally what `sort` is for.


One thing about bash and awk: it's FAST...

```bash
 time awk -f aoc-1-1.awk input-l | sort -n | tail -1
 69795
 awk -f aoc-1-1.awk input-l  0.00s user 0.00s system 73% cpu 0.008 total
 sort -n  0.00s user 0.00s system 58% cpu 0.007 total
 tail -1  0.00s user 0.00s system 58% cpu 0.006 total

```
Note that for brevity, I added an additional `tail` so that it would only print the line we're interested in.

I doubt many of the more "elegant" solutions are faster; I'd wager most are slower

### Challenge 2

Since I already had everything I needed in the output of the first Challenge, I just added a `tail | awk` to get the sum of the last three values out of the `sort`:

```bash
awk -f aoc-1-1.awk input-l | sort -n | tail -3 | awk '{ sum += $0 } END { print sum}'
```

```bash
 time awk -f aoc-1-1.awk input-l | sort -n | tail -3 | awk '{ sum += $0 } END { print sum}'
 208437
 awk -f aoc-1-1.awk input-l  0.00s user 0.00s system 70% cpu 0.009 total
 sort -n  0.00s user 0.00s system 49% cpu 0.008 total
 tail -3  0.00s user 0.00s system 38% cpu 0.007 total
 awk '{ sum += $0 } END { print sum}'  0.00s user 0.00s system 53% cpu 0.006 total
```

---

