#!/bin/bash
#=
exec julia --color=yes --startup-file=no -e 'include(popfirst!(ARGS))' \
    "${BASH_SOURCE[0]}" "$@"
=#

# The above follows practice outlined in FAQ:
# https://docs.julialang.org/en/v1/manual/faq/#How-do-I-pass-options-to-julia-using-#!/usr/bin/env?
#
# Example usage:
#
# echo "a
# b
# c" | ./hello.jl

for line in eachline(stdin)
    println("hello " * line) 
end

