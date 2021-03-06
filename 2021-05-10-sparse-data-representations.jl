# Mon May 10 09:58:51 PDT 2021
#
#------------------------------------------------------------
# Sparse data representations
#------------------------------------------------------------
#
# Outcomes:
#
# 1. Estimate the approximate size of dense and sparse numeric matrices.
#
#
# Plan for this week:
#
# - Wednesday: discussion
#       impact of big data on society
#
# - Friday: final review
#       I'll post a list of outcomes for the last half of the course
#
# 123 GO: What's the first thing you're going to do when you're done with finals?
#
# Background
#------------------------------------------------------------
# Why do we care about representing data in a memory efficient way?
# When does it matter?
#
# If the data is small, then it doesn't matter at all.
# If the data is very large, then it might matter!
# Program might not even run if there's too much data.


# Generators (and Iterators)
#------------------------------------------------------------
# https://docs.julialang.org/en/v1/manual/arrays/#Generator-Expressions-1

x = 1:10

# `collect()` generally converts an object to a dense format
xc = collect(x)

# Object that's way too big:
y = 1:10000000000000000
# Fails with Out of memory errror
yc = collect(y)

sizeof(1)
sizeof(10)

sizeof(x)

# 123 go
sizeof(xc)
sizeof(xc[1]) * length(xc)

g = (xi^2 for xi in x)

gc = collect(g)

sizeof(gc)

sizeof(g)

# g is a generator.
# What must g be storing?

# function
g.f
# AST abstract syntax tree
code_lowered(g.f)

function square(xi)
    xi^2
end

code_lowered(square)

# iterator
g.iter


# Dense arrays
#------------------------------------------------------------
# "Dense" means every element exists in memory.

# 123 go:
# Which of these objects are dense? x, xc, y, g
# Only xc


# Principle:
# When should you `collect()` objects?
# Wait until you're forced to!

n = 100
x = rand(Float64, (n, n))

x11 = x[1, 1]

sizeof(x11)

typeof(x11)

# 123 GO
sizeof(x)
# each element is 8 bytes
# It's an n x n array where n = 100
8 * n * n

xb = x .< 0.5

xb11 = xb[1, 1]

sizeof(xb11)

sizeof(xb)
n * n / 8

sizeof(x) / sizeof(xb) 

# Sparse arrays
#------------------------------------------------------------
# Sparse arrays have few nonzero entries.
# 10% or less is typical.
#
# Sparse matrices for document term matrix
#
# 123 GO:
# How can we use this property?
# 1. Memory storage - only need to store nonzero entries, and their locations
# 2. Mathematically - 0*x = 0, 0+x = x, so you need to do MUCH less computation.
#
# https://docs.julialang.org/en/v1/stdlib/SparseArrays/

using SparseArrays


n = 100
s = zeros(n, n)

# 123 go - is s dense or not?
# yes, right now

# Consider a matrix that only has nonzero entries on the diagonal.
for i in 1:n
    s[i, i] = i
end

s2 = sparse(s)

sizeof(s)

sizeof(s2)


3 * 8 * n

# let's recursively check the size
Base.summarysize(s2)

# how large is the sparse version relative to the dense?
Base.summarysize(s2) / sizeof(s)

# What other special matrices are there?
# https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#Special-matrices


# Side note:
#------------------------------------------------------------
# How the computer represents floating points numbers
#
# https://docs.julialang.org/en/v1/base/numbers/
