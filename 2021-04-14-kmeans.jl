# Outcomes:
#
# 1. Simulate data to understand statistical methods and software.
# 2. Validate intuition around kmeans clustering model.
#
# 123 GO - share a short inspirational quote or phrase
#
# Announcements:
#
# 1. Turn in HW early tonight for early grading / feedback tomorrow.
# 2. Submit course substitution petition and see advisor to count this class as an elective.
# 3. April 22 Candice Price Change Maker talk http://webpages.csus.edu/wiscons/events/ChangeMaker.html
# 4. R programming job

import Random
using Plots
using Distributions

plotly()
SZ = (1000, 800)


# Let's make some 3D data with two clusters!

n = 100

# DRY?
x = rand(Normal(), n)
y = rand(Normal(), n)
z = rand(Normal(), n)


# tuple unpacking


# Add the clustering structure
cluster1_index = 1:10

# Shift by 3
x[cluster1_index] .+= 8

# plot
#scatter(x, y, z, size = SZ)


# kmeans
#############################################################
import Clustering

xyz = transpose(hcat(x, y, z))

nclusters = 2

# 123 GO: What should be the size of X to input below?
# 3 dimensions
# n = 100 data points
# X should be 3 by 100
k2 = Clustering.kmeans(xyz, nclusters)

grp1 = k2.assignments .== 1
grp2 = k2.assignments .== 2

scatter(x[grp1], y[grp1], z[grp1], size = SZ, label = "group 1")
scatter!(x[grp2], y[grp2], z[grp2], size = SZ, label = "group 2")

# We shifted x coordinate by 6
scatter!(k2.centers[1, 1:end], k2.centers[2, 1:end], k2.centers[3, 1:end], label = "centers")

"""
    Find the indices of the data points that are closest to the centroids defined by the kmeans clustering.
"""
function close_centroids(knn_model)
    groups = knn_model.assignments
    k = length(unique(groups))
    n = length(groups)
    result = fill(0, k)
    for ki in 1:k
        cost_i = fill(Inf, n)
        group_i = ki .== groups 
        cost_i[group_i] = knn_model.costs[group_i]
        result[ki] = argmin(cost_i)
    end
    result
end

cc = close_centroids(k2)

scatter!(x[cc], y[cc], z[cc], label = "closest data points")

scatter!([0, 6], [0, 0], [0, 0], label = "true centers")


# 
# 123 GO- What is the absolute minimum this model needs to contain to classify a new data point into a cluster?
# Centers

# 123 GO- Are these results typical in true data analysis?

# Some helpful functions
#############################################################
# Use these, don't reimplement!


import StatsBase

StatsBase.counts(k2.assignments)


import Statistics

Statistics.sortperm


# Ryan's example:
#############################################################

using SparseArrays

A = [1 2 0 8 1 0; 0 0 0 3 2 3; 0 1 1 0 0 1; 0 2 0 3 1 0]
lonelySub = sparse(A)

onlySub = sum(A .> 0, dims = 1)
onlySub = sum(x->x>0, lonelySub, dims = 1)
onlySub = sum(lonelySub .> 0, dims = 1)

onlySub = dropdims(onlySub, dims = 1)

fewer_than_2 = onlySub .< 2
two_or_more = 2 .<= onlySub

#two_or_more = collect(two_or_more)

A[1:end, [false, true, false, true, true, true]]

A[1:end, two_or_more]



showMe = map(remove_col, lonelySub)
println(showMe)


###

for i in 1:6
        if lonelySub[i] < 2
                lonelySub = lonelySub[:, 1:end .! = i]
        end
end
