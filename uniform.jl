using StatsPlots
using Distributions


# U1k represents a uniform(0, 1000) distribution
U1k = Uniform(0, 1000)

# A random sample from this distribution
x = rand(U1k, 50)

normalD = Normal(mean(x), std(x))

qqplot(Uniform, x)

qqplot(Normal, x)
qqplot(Normal, x)
