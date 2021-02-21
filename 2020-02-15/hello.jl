# text editor containing the file "hello.jl"

function greet(x)
    println("hello " * x)
end

# 123 GO- predict- will the script work? yes, no, idk
# If there is a default arg to eachline, and it is stdin, then this should work.

function main()
    for line in eachline()
        greet(line)
    end
end
