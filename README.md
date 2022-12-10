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

---
## Day 4 (Dec 4)
### Challenge 1

Today was a challenge for me. I was able to complete it, but it took a lot of false starts. The logic seems pretty ugly.

In the end a key realization for me was that if *either* the first or second parts are the same, there's automatically overlap.  This causes the traditional `<=` logic to break down, so I had to evaluate for `==`, `<` and `>` separately.  Also, I have a tendency to forget that `=` is not the same as `==` in virtually any language. I've been doing this long enough to know better, but maybe you can find comfort in knowing that you are not alone if you struggle with that. Or maybe it is just me....

In any case, logic problems aside, the awk is actually not overly complex, once you get everything evaluating in the correct order.

In the process of troubleshooting my logic, as all good progammers do, I inserted some `printf()` statements. I was curious about the real performance impact of the extra printf's, so although I removed most of them, I kept one so I could compare them. Turns out to have less impact than I though, though it could be inferred that adding more could have a significantly larger impact. Still, it's well under a second, and it can provide valuable insight to what your program is doing:

With the `printf()`:
```bash
time awk -F ',' -f 4-1.awk input-4
    3 : 87-89,7-88 = no match
    4 : 82-93,44-82 = no match
...
    995 : 7-65,2-7 = no match
    999 : 7-96,3-8 = no match
511 contained in 1000 linesawk -F ',' -f 4-1.awk input-4  0.01s user 0.00s system 74% cpu 0.012 total
```

Without the `printf()`:
```bash
time awk -F ',' -f 4-1v2.awk input-4
511 contained in 1000 linesawk -F ',' -f 4-1v2.awk input-4  0.01s user 0.00s system 81% cpu 0.009 total
```

As you can see, it's measurable, but not huge. Then agin, scaled to millions of lines instead of 1000, that 0.003 seconds can add up.

### Challenge 2

After my struggle with part 1, this one was a piece of cake. I copied my initialization part and `END` clause from part one.  Got it on the first try!

Again, with a spurious `printf()`:
```bash
time awk -F ',' -f 4-2.awk input-4
   14 : 29-75,28-28 = no match
   15 : 18-74,1-17 = no match
   17 : 68-68,27-67 = no match
...
  976 : 4-11,12-12 = no match
  988 : 26-26,27-96 = no match
821 overlap in 1000 linesawk -F ',' -f 4-2.awk input-4  0.01s user 0.01s system 61% cpu 0.019 total
```

And without:
```bash
time awk -F ',' -f 4-2v2.awk input-4
821 overlap in 1000 linesawk -F ',' -f 4-2v2.awk input-4  0.01s user 0.00s system 67% cpu 0.013 total
```

As with part one, not a huge difference, but enough to matter with a sufficiently large data set. In other words, choose your weapons wisely :D

---
## Day 5
### Challenge 1

Will I be able to catch up?

### Challenge 2

Sorry this will mess with "just scroll to the bottom for the latest update"

---
## Day 6 (Dec 6)
### Challenge 1

I happened to be awake at midnight EST, so I skipped ahead to get the points...

After a couple of false starts due to faulty logic, I got this to work. However, because of the way I built this, I needed only to change a variable assignment to finish challenge 2, once I got the bugs worked out.

The algorithm is pretty simple:
1. grab a chunk of the string the size we need (4 chars for challenge 1)
2. compare the first character of that chunk to the remaining characters, looking for a match
3. if no match is found, compare the next character to the remaining characters
4. repeat steps 3 & 4 until we have compared every character to all of the following characters
5. if no match is found, we have enough unique characters, so print the starting position of the match and quit.

For challenge 1, that means the inner loop must run 3 times. For challenge 2, it had to run 13 times...
I don't have to compare every character to *every* other character in the chunk, because I've *already* compared to all the previous characters. I could probably optimize by skipping the rest of the loop if I find a match, rather that completing the entire inner loop every time...

However, it's still pretty fast;
```bash
time awk -f 6-1.awk input-6
1658
awk -f 6-1.awk input-6  0.01s user 0.00s system 87% cpu 0.013 total
```

After adding that optimization:
```bash
time awk -f 6-1v2.awk input-6
1658
awk -f 6-1v2.awk input-6  0.01s user 0.00s system 85% cpu 0.011 total
```

### Challenge 2

As mentioned above, I only had to change the size of the chunk to complete part 2. This was super easy:
```bash
time awk -f 6-2.awk input-6
2260
awk -f 6-2.awk input-6  0.03s user 0.00s system 94% cpu 0.038 total
```

Now we're starting to tax the system a little bit.

Interestingly, I would have expected adding the "early out" from the inner loop to have more impact given the larger loop size, but the constraint appears to be something else. While it *is* faster, it's not appreciably so:
```bash
time awk -f 6-2v2.awk input-6
2260
awk -f 6-2v2.awk input-6  0.03s user 0.00s system 94% cpu 0.037 total
```

---
## Day 7 (Dec 7)
### Challenge 1

I'm not going to lie, today's challenge *really* irritated me.
- Any system with a terminal that uses a root-based file system, and has `rm` and `ls` as commands also probably supports the use of the `du` command.
- While most of the problems so far require an amount of suspension of disbelief, at least the basic algorithm might have useful real-world applications. However, today's algorithm will not give you any useful real-world results. The problem statement sort-of acknowleges this, but it also pretty much obviates the use of any of the tools a competent Systems Engineer might use. If you try to use any of this algorithm to solve a real-world 'device full' problem, you may well wind up making things worse.

The *correct* answer would be to use `du -chx --max-depth=1 /` and then progress through the tree looking for things you know are safe to delete, which will probably be in `/var/log`.

In the end, most of the trouble I had with getting the "right" answers involved what amounts to a recursion problem. I didn't want to use recursion, because in a *real world* situation, you might well face device constraints like memory limits that preclude building a giant in-memory map. On most modern computing devices you are unlikely to run into that problem, but then again, the theoretical device in question is already fairly constrained; similarly, we may face an embedded device such as an ESP8266 or ESP32 which may be quite constained.  My awk-based solution would run fine on those devices, and even smaller devices such as many Arduinos, which may not be capable of running cPython or Rust.

Once I was able to figure out how to get the size of a directory to pass correctly up to the parent on a `cd ..`, (which wouldn't be necessary in the real world...can you tell I'm still salty about that bit? :D ), I was able to get my tree-based solution to work and print out the correct size summary for each directory. From there, I just needed to look over those results, and total up the ones we care about:
```bash
awk -f 7-1.awk input-7 | awk ' {if ($2 <= 100000) {total += $2; } } END { print "total: " total}'
total: 1077191
```

Running inside of `time`:
```bash
time awk -f 7-1.awk input-7 | awk ' {if ($2 <= 100000) {total += $2; } } END { print "total: " total}'
total: 1077191
awk -f 7-1.awk input-7  0.01s user 0.00s system 83% cpu 0.010 total
awk ' {if ($2 <= 100000) {total += $2; } } END { print "total: " total}'  0.00s user 0.00s system 32% cpu 0.010 total
```
0.02 seconds total. Pretty good for a scripting language originally developed 50 years ago...

### Challenge 2

With the first challenge sorted out, the second was pretty easy:
I just need to sort the results from challenge 1 so that the biggest (`/`) directory is first, and use that value to figure out how much space I need to find, then print all the matching results. Because the results are *already* sorted largest to smallest, the last line of output will be what I want. For a more concise output, I could add a `tail -1` to the pipe, but this output is short enough:
```bash
time awk -f 7-1.awk input-7 | sort -nrk 2 | awk -f 7-2.awk
used: 45174025
avail: 24825975
Need: 5174025
/: 45174025
/lqblqtng/: 27642694
/lqblqtng/vgt/: 25773269
/lqblqtng/vgt/jqnvscr/: 11694215
/hdh/: 10851370
/hdh/cljdmh/: 9665817
/lqblqtng/vgt/tmf/: 9510609
/lqblqtng/vgt/tmf/rdcsmpfm/: 6824953
/lqblqtng/vgt/tmf/rdcsmpfm/lqblqtng/: 6175618
/hdh/cljdmh/hdh/: 5649896
awk -f 7-1.awk input-7  0.01s user 0.00s system 81% cpu 0.012 total
sort -nrk 2  0.00s user 0.00s system 40% cpu 0.012 total
awk -f 7-2.awk  0.00s user 0.00s system 39% cpu 0.011 total
```
A bit longer to execute due to the overhead of spinning up two additional processes, but still, 0.03 seconds total seems pretty good to me

---
## Day 8 (Dec 8)
### Challenge 1

Despite my frustration yesterday, I kept going because it is pretty fun, even if it's annoying.

The basic logic here wasn't difficult, though it took longer than strictly necessary because I kept trying to short circuit the logic in order to get results faster.

In the end, I am actually testing all the way to the edge for each case; After I succeeded, I realized how to speed up the checks with short-circuit, but then in part 2, you have to check every tree all the way to the edge anyway.

It's a little disconcerting to have a thing run for 2 seconds when you are used to sub-second results, though, but still, considering that I am checking 9801 squares 98 times in each direction (9801 * 196), that's almost 2 million checks in 1.5 seconds...that's pretty fast.

```bash
time awk -f 8-1.awk input-8
99 lines read
1688 visible in 9801 cells.
awk -f 8-1.awk input-8  1.43s user 0.00s system 99% cpu 1.433 total
```

### Challenge 2

I forgot to copy the original file before I started work on part 2...

As expected, because I was already running all 2,000,000 checks for part 1, part 2 wasn't difficult. I just had to throw a score calculation into the program, and add a new array to store the score. As a result, there isn't a large time difference between the two programs.

```bash
time awk -f 8-2.awk input-8
99 lines read
1688 visible in 9801 cells. Max score is 410400
awk -f 8-2.awk input-8  1.46s user 0.01s system 99% cpu 1.466 total
```
