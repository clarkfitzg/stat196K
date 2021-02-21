- create and interpret QQ plots
- sample from probability distributions to test statistical methods

Important meta technique for understanding statistical methods: simulate data that exactly matches the assumptions and check that it works as expected.

Motivation: We would like to characterize a data generating process with a distribution, i.e. uniform, normal, Poisson, etc.
Why do we want to do this?

## Resources

- We already have code in Julia to do the [QQ plot](https://github.com/JuliaPlots/StatsPlots.jl#quantile-quantile-plots)

```julia
using GR
using Distributions
```

The QQ (quantile - quantile) plot is a useful visual tool to check if whether a particular distribution models data well.
If the QQ plot follows the line y = x reasonably well, then it means that the reference distribution is a reasonable model for the data.

Let's simulate from a uniform distribution.

```julia
U1k = Uniform(0, 1000)

x = rand(U1k, 50)
```

`quantile` gives us the quantile function.

```julia
quantile(U1k, 0.5)
```

123 GO- which quantiles should we plot for these 1000 data points?
If we plot the sorted data against these theoretical quantiles, we should see line along y = x.

```julia
q1k = quantile(U1k, range(0, 1, length = length(x)))
scatter(q1k, sort(x))
```

