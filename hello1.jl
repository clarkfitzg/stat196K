# Example usage:
#
# $ seq 3 | julia hello.jl
# hello 1
# hello 2
# hello 3


function greet(x)
    println("hello " * x) 
end


# Process stdin
for line in eachline()
    greet(line)
end
