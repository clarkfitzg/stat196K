# Example usage:
#
# $ seq 3 | julia hello.jl
# hello 1
# hello 2
# hello 3


function greet(x)
    println("hello " * x) 
end


function main()
    for line in eachline(stdin)
        greet(line)
    end
end


# Could introduce this later, after motivating it.

if abspath(PROGRAM_FILE) == @__FILE__
    # Run the main script
    main()
end
