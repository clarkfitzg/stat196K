
Idea: come up with a reservoir sampling scheme that doesn't take longer than a fixed amount of time, meaning it stops once a certain amount of time has passed.

1. Suppose we halt reservoir sampling at item m, with m < n, where n is the size of the entire stream.
    Can this be a sample of the entire data?
    Explain.

2. Test your implementation of the algorithm on the uniform distribution on the positive integers.
Use the Kolmogorov-Smirnov test or the Chi squared test to see how close your distribution is to the expected.
Plot some QQ plots to verify that the distribution looks as you expect.

Idea: This could be a good lead in to parallel programming.
Simulations are the easiest things to parallelize.
    
3. Which of these will produce a simple random sample?

```
head data.txt | reservoir_sample
reservoir_sample data.txt | head
```

4. Wikipedia claims simple reservoir sampling is slow.
Is it?
