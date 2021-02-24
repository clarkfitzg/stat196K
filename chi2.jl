#construction

using Distributions
using StatsPlots

nmax = 1e6

# Discrete uniform random variable
U = DiscreteUniform(1, nmax)

nsample = 100

# Random sample
x = rand(U, nsample)

# should appear somewhat flat
histogram(x)

expected_bin_count = 10

# calculated based on what we already specified
nbins = Int(floor(nsample / expected_bin_count))

# Basing histogram breaks on the quantiles helps this code generalize
q = range(0, 1, length = nbins + 1)
q = collect(q)
breaks = quantile(U, q)


# This implementation is higher level and prettier to me.
function table(x, breaks)
    K = length(breaks)-1
    counts = zeros(Int, K)
    for i in 1:K
        counts[i] = sum(breaks[i] .< x .<= breaks[i+1])
    end
    counts
end


# This implementation is more algorithmic and harder to read.
function table_ugly(x, breaks)
    counts = zeros(Int, length(breaks)-1)
    for xi in x
        bin = 0
        for b in breaks
            if xi < b
                counts[bin] += 1
                break
            end
            bin += 1
        end
    end
    counts
end


# Another approach
# x_binned = CategoricalArrays.cut(x, breaks)


x_counts = table(x, breaks)

# Based on the way we constructed 
expected_counts = 



