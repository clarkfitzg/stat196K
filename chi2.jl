# Simulate data and make QQ plots

using Plots
using Distributions

# Initialize plotting
gr()

# U1k represents a uniform(0, 1000) distribution
U1k = Uniform(0, 1000)

# A random sample from this distribution
x = rand(U1k, 50)

# evenly spaced quantiles
q1k = quantile(U1k, range(0, 1, length = length(x)))

plot(q1k, sort(x))

title("data comes from distribution - GOOD")

plot(q1k, sort(x))
function qqplot(d::UnivariateDistribution, x)
    rng = range(0, 1, length = length(x) + 2)[2:(end-1)]
    q = quantile(d, rng)
    GR.scatter(q, sort(x))
end

title("data not from distribution - BAD")
qqplot(U1k, x)

normalD = Normal(mean(x), std(x))

qqplot(normalD, x)

