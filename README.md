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
## Day 2 (Dec 2)
### Challenge 1

This challenge is deceptively simple. It seems like it's going to require some kind of array/matrix.  But it turns out that you can really break it down to a handful of `if...then` statements.  Even the scoring model is pretty straightforward.

Again, this kind of text processing is what `awk` and the CLI in general were written for:
```bash
time awk -f 2-1.awk input-2
final score: 14069
awk -f 2-1.awk input-2  0.01s user 0.00s system 77% cpu 0.016 total
```

Under 2 hundredths of a second to process 2500 lines of text... not too shabby.

In case you are wondering how I know that I have 2500 lines in that file:
```bash
wc -l input-2
    2500 input-2
```
Yes, vim would tell you how many lines are in that file if I copy/pasted from the AoC website, but why would I do that when there are cli tools for exactly this purpose?
```bash
curl -H 'cookie: session=5361645f5fd400dc6c1e8af5e-nice-try-0afe8afcccda5465bfd3fc61-not-my-real-session-cookie-ff0ed57e423ad' "https://adventofcode.com/2022/day/2/input" -o input-2
```

I didn't even look at the data, beyond confirming that it looked like what I expected.

### Challenge 2

The revised parameters actually simplify the logic considerably. I could have done something similar for the first part, which in turn would actually have made it easier to adapt, but it seemed better at the time to separate the 'win-lose-draw' logic from the 'points-per-shape' logic. With the revised decoding key, that no longer makes sense, but the basic logical structure remains sound.

```bash
time awk -f 2-2.awk input-2
final score: 12411
awk -f 2-2.awk input-2  0.01s user 0.00s system 85% cpu 0.014 total
```

Because there are less `if` statements, this turns out to be slightly faster.  The whole thing could potentially be optimezed with `if...else` instead, for sufficiently large data sets. In this case, I did test that approach for both challenge 1 and 2 (`./2022/2-1v2.awk` and `./2022/2-2v2.awk`), but for this sample size it wasn't a measurable difference.

---
## Day 3
### Challenge 1

I don't really computer on the weekend, so I fell a bit behind. Hopefully I will be able to catch up...

This is another challenge where AWK is fairly well suited to the task. In particular, for the calculation of the "score", AWK's `match` or `index()` functions can work for arbitrary strings, and will reliably return the correct index. This means that once the stipulated criteria were identified, it was easy to calculate the score.

For part 1, I used a single awk program to split the string in half, and then compare the two halves. `gawk` would have simplified the task slightly, but doing it this way allowed me to remain POSIX compliant.

And again, awk churns through the 300 lines of input blazing fast:
```bash
time awk -f 3-1.awk input-3
total is: 7766
awk -f 3-1.awk input-3  0.01s user 0.01s system 71% cpu 0.021 total
```

Printing out all the outputs slows things down; while that might be useful in a real-life scenario, that's not necessary or helpful here.

### Challenge 3

I chose to adopt a two-step process for this challenge, and I realized that I probably overcomplicated the first part.

The first awk program just creates the sets of three required for the second program. This is sufficiently straightforward that I didn't bother putting it into an actual file. I just typed in in, and then used a bash pipe (|) to feed the output of that into the input for the second program that did the actual comparison.

Even though this challenge is more computation-heavy, because the algorithm is much simpler, it's faster, executing in roughly half the time of the first challenge;
```bash
time awk 'BEGIN {i=1} {printf("%s ",$0); i += 1; if (i > 3) {print ""; i=1} } ' input-3 | awk -f 3-2.awk
total is: 2415
awk 'BEGIN {i=1} {printf("%s ",$0); i += 1; if (i > 3) {print ""; i=1} } '   0.00s user 0.00s system 73% cpu 0.006 total
awk -f 3-2.awk  0.00s user 0.00s system 78% cpu 0.007 total
```
0.007 + 0.006 = 0.013, compared to 0.021 for the first part.

I'm quite happy with the results so far.
