# Mon May 10 09:58:51 PDT 2021
#
#------------------------------------------------------------
# Sparse data representations
#------------------------------------------------------------
#
# Outcomes:
#
# 1. Estimate the size of dense and sparse numeric matrices.
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
#
# Background
#------------------------------------------------------------
# Why do we care about representing data in a memory efficient way?
# When does it matter?
#


# Generators (and Iterators)
#------------------------------------------------------------
# https://docs.julialang.org/en/v1/manual/arrays/#Generator-Expressions-1
#

x = 1:10

sizeof(1)

sizeof(x)

# `collect()` generally converts an object to a dense format
x2 = collect(x)

sizeof(x2)

y = 1:1_000

sizeof(y)

sizeof(collect(y))

g = (xi^2 for xi in x)

sizeof(g)

# g is a generator.
# What must g be storing?

g.iter

g.f

# We're looking at an abstract syntax tree (AST)
code_lowered(g.f)

function square(xi)
    xi^2
end

code_lowered(square)


# Dense arrays
#------------------------------------------------------------
# "Dense" means every element exists in memory.

# 123 go:
# Which of these objects are dense? x, x2, y, g

# Principle:
# When should you `collect()` objects?

x = rand(Float64, (100, 100))

x11 = x[1,1]

sizeof(x11)

# 123 GO:
# What will this be?
sizeof(x)


xb = x .< 0.5

xb11 = xb[1, 1]

sizeof(xb11)

sizeof(xb)

100 * 100 / 8


# How much smaller is the BitArray versus the Float64 array?

sizeof(x) / sizeof(xb)


# Sparse arrays
#------------------------------------------------------------
# Sparse arrays have few nonzero entries.
# 10% or less is typical.
#
# How can we use this property?
# 1. Memory storage
# 2. Mathematically
#
# https://docs.julialang.org/en/v1/stdlib/SparseArrays/


using SparseArrays

# Consider a matrix that only has nonzero entries on the diagonal.
n = 100

s = zeros(n, n)

for i in 1:n
    s[i, i] = i
end

sizeof(s)

s2 = sparse(s)

sizeof(s2)
# Can it be so small?

Base.summarysize(s2)

3*8*n


# What other special matrices are there?
# https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#Special-matrices


# Side note:
#------------------------------------------------------------
# How the computer represents floating points numbers
#
# https://docs.julialang.org/en/v1/base/numbers/
#
a = 1.2891
sizeof(a)

significand(a)

exponent(a)

significand(a) * 2.0^exponent(a)
