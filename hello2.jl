# hello2.jl

function greet(x)
    println("hello " * x) 
end


for line in eachline(stdin)
    greet(line)
end
