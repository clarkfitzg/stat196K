# Outcomes:
#
# 1. Simulate data to understand statistical methods and software.
# 2. Validate intuition around kmeans clustering model.
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
x = rand(Normal(), n)
y = rand(Normal(), n)
z = rand(Normal(), n)

# tuple unpacking
a, b = 1, 2

a, b = (x^2 for x in 1:2)

# Which do you prefer?
x, y, z = (rand(Normal(), n) for i in 1:3)


# Add the clustering structure
cluster1_index = 1:50

x[cluster1_index] .+= 8
# There are two clusters. 
# What are the centers?
# (0, 0, 0) and (8, 0, 0)

scatter(x, y, z, size = SZ)


# kmeans
#############################################################
import Clustering

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


# what dimension matrix do we need to give kmeans?
# 3 rows x 100 columns

xyz = transpose(hcat(x, y, z))

nclusters = 2

# Find two clusters
k2 = Clustering.kmeans(xyz, nclusters)

grp1 = k2.assignments .== 1
grp2 = k2.assignments .== 2

scatter(x[grp1], y[grp1], z[grp1], size = SZ, label = "group 1")
scatter!(x[grp2], y[grp2], z[grp2], label = "group 2")

# 123 GO- What is the absolute minimum this model needs to contain?

# Clustering worked perfectly!
k2.centers

scatter!(k2.centers[1, 1:end], k2.centers[2, 1:end], k2.centers[3, 1:end], label = "centers")

# Now let's find the close centroids
cc = close_centroids(k2)

scatter!(x[cc], y[cc], z[cc], label = "closest data points")


# 123 GO - Do you think this usually happens?


# Some helpful functions
#############################################################
# Use these, don't reimplement!


import StatsBase

StatsBase.counts


import Statistics

Statistics.sortperm
