#!/bin/bash
#=
exec julia --color=yes --startup-file=no -e 'include(popfirst!(ARGS))' \
    "${BASH_SOURCE[0]}" "$@"
=#

# The above follows practice outlined in FAQ:
# https://docs.julialang.org/en/v1/manual/faq/#How-do-I-pass-options-to-julia-using-#!/usr/bin/env?
#
# This shebang line is a rats nest.
# From the FAQ, it seems like I cannot catch CTRL+C, and have an executable, and be able to import it?
# Oh well.
#
# Example usage:
#
# echo "a
# b
# c" | ./hello.jl

function main()
    for line in eachline(stdin)
        println("hello " * line) 
    end
end
