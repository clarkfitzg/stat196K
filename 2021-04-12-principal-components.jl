# Outcomes:
#
# 1. Simulate data to understand statistical methods and software.
#
# 123 go - how is the dating scene like in COVID era?
# 1 word.

import Random
using MultivariateStats
using Plots
using Distributions

plotly()
SZ = (1000, 800)


# Let's make a data cloud that varies mostly along the line y = x.

n = 100
x = rand(Normal(), n)
noise_level = 0.3
y = x + noise_level * rand(Normal(), n)

scatter(x, y, legend = false, size = SZ)


# PCA

# 100 rows, 2 columns
xy = hcat(x, y)

# Docs require: each observation in a column
#
# 123 GO: Is the data in the right form? yes, no, idk
# No, need the transpose
xy = transpose(hcat(x, y))

pca1 = fit(PCA, xy, maxoutdim = 1)

# What should be the first principal component direction?
# 1/sqrt(2) for a unit vector
# [0.71, 0.71]
# 123 go - is this the only possible vector?
projection(pca1)

# Transformations
#
# Now we want to reduce the dimensions of our data
xy_trans = transform(pca1, xy)

# Why go back to the original space?
xy_approx = reconstruct(pca1, xy_trans)

scatter!(xy_approx[1, 1:end], xy_approx[2, 1:end])


# We have a cigar shaped distribution
# 2d -> 1d

# What kind of 3d object is the equivalent of a "cigar"
# "pancake"
# 3d -> 2d
#
# plane, rectangle, sidewalk, cylinder,

z = rand(Normal(), n)

scatter(x, y, z, size = SZ, legend = false)

xyz = transpose(hcat(x, y, z))

pca2 = fit(PCA, xyz, maxoutdim = 2)

projection(pca2)


# variance in each component
principalvars(pca2)

# total variance
tvar(pca2)

# Relatively how much variance is explained by each principal component?
principalvars(pca2) / tvar(pca2)
#  0.5966720382480819
#  0.3900237303088085
#  First component explains 59.67 % of total data variation
#  Second component explains 39 % of total data variation

# In HW:
# first 10 or 20 dimensions explained 60% of data variation

# Does it matter to PCA if we shift the data? (translation invariance)
#

n = 100
x = rand(Normal(), n) .+ 10
noise_level = 0.3
y = x + noise_level * rand(Normal(), n) .- 17
scatter(x, y, legend = false, size = SZ)


xy = hcat(x, y)
xy = transpose(hcat(x, y))
pca1 = fit(PCA, xy, maxoutdim = 1)

# Will the first PC vector be the same direction?
# [0.71, 0.71]
# 123 go: yes no, idk?

projection(pca1)


# Office hours
#
# Top 20 most frequently appearing words
using Serialization

using Statistics

termfreq = deserialize("/Users/fitzgerald/data/termfreq.jldata")

irs990extract = deserialize("/Users/fitzgerald/data/irs990extract.jldata")

x = irs990extract[1]
parse(Int, x["volunteers"])

function parse_vol(x)
    v = x["volunteers"]
    if ismissing(v)
        0
    else
        parse(Int, x["volunteers"])
    end
end

volunteers = map(parse_vol, irs990extract)

mostvol = sortperm(volunteers, rev = true)

top20idx = mostvol[1:20]

# pick out the top 20 from the irs990 extract
top20 = irs990extract[top20idx]

top20[1]

top20[2]["mission"]

top20[3]

# pick out the top 20 from the termfreq
top20terms = termfreq[top20idx, 1:end]
