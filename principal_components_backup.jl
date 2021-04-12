# Outcomes:
#
# 1. Simulate data to understand statistical methods and software.

import Random
using MultivariateStats
using Plots
using Distributions
#using StatsBase

plotly()
SZ = (1000, 800)

# Generate the same random numbers.
Random.seed!(8390)


rv = Normal()

# Let's make a data cloud that varies mostly along the line y = x.
n = 100
x = rand(rv, n)
y = x + 0.3 * rand(rv, n)
scatter(x, y, legend = false, size = SZ)



# PCA

xy = hcat(x, y)

# Read docs: https://multivariatestatsjl.readthedocs.io/en/stable/pca.html#fit
# 123 go - will our xy work?

xyt = transpose(xy)

pca1 = fit(PCA, xyt, maxoutdim = 1)

# Inspect the fitted model

p11 = projection(pca1)

# We can take new or old data points and transform them so they lie in the subspace defined by the model.

pc_space_xyt = transform(pca1, xyt)
xyt_approximate = reconstruct(pca1, pc_space_xyt)

scatter!(xyt_approximate[1, 1:end], xyt_approximate[2, 1:end], size = SZ)


# We have a cigar shaped distribution
# Now let's make a pancake shaped distribution.

# No relationship to x, y coordinates
z = rand(rv, n)


scatter(x, y, z, size = (1000, 1000), legend = false)

X3 = transpose(hcat(x, y, z))

pca2 = fit(PCA, X3, maxoutdim = 2)

projection(pca2)

principalvars(pca2)

# total variance
tvar(pca2)

# Relatively how much variance is explained by each principal component:
principalvars(pca2) / tvar(pca2)


# Does it matter to PCA if we shift the data? (translation invariance)

n = 100
x = rand(rv, n) .+ 5
y = x + 0.3 * rand(rv, n) .- 10
scatter(x, y, legend = false)

X4 = transpose(hcat(x, y))
pca4 = fit(PCA, xyt)

projection(pca4)
