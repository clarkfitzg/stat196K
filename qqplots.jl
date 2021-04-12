using Random
using Distributions
using StatsPlots

Random.seed!(420)

c5 = Chisq(5)
u8 = Uniform(0, 8)

n = 30


p1 = qqplot(c5, rand(c5, n))
title!("A")
p2 = qqplot(c5, rand(n))
title!("B")

x = rand(u8, n)
x[4 .< x] .+= 5
p3 = qqnorm(x)
title!("C")

p4 = qqplot(u8, rand(c5, n))
title!("D")

plot(p1, p2, p3, p4, layout = 4)
