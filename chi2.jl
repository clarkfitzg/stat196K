using Distributions
using StatsPlots

import HypothesisTests

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


# This implementation is higher level and more clear to me.
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

# All the same because we constructed them based on quantiles.
expected_counts = fill(expected_bin_count, length(x_counts))

# Pearson's Chi Squared statistic
chi_stat = sum((x_counts - expected_counts).^2 ./ expected_counts)

# Two sided P-value calculation
chi_rv = Chisq(length(x_counts) - 1)
pval = cdf(chi_rv, chi_stat)
# Multiply by two to get the two sided p value, and handle the case when pval > 0.5
pval = pval > 0.5 ? 1-pval : pval
pval = 2 * pval

# Verify statistic and pvalue calculation with external library
expected = HypothesisTests.ChisqTest(x_counts)
pval_check = HypothesisTests.pvalue(expected, tail = :both)

# These numbers should be the same up to numerical precision, 1e-16 or so.
abs(pval - pval_check)
