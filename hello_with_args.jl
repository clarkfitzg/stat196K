# Example usage:
#
# $ seq 3 | julia hello2.jl " bye now"
# hello 1
# hello 2
# hello 3



function greet(x, after = "")
    println("hello " * x * after)
end


function main()
    # Process stdin
    user_after = ARGS[1]
    for line in eachline()
        greet(line, user_after)
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    # Run the main script
    main()
end
