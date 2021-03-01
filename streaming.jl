
function main()
    count = 1
    res = ["", "", ""]
    for line in eachline()
        index = rand(1:count)
        if index <= length(res)
            res[index] = line
        end
        count += 1
    end
    for e in res
        println(e)
    end
end

main()
