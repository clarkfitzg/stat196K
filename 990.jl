# Skills:
# 
# designing functions
# debugging
#
# Notes: 
# http://webpages.csus.edu/fitzgerald/julia-debugger-tutorial/
#
# What does your development process look like?
# For example:
#
# How do you write code?
# When do you write a function?
# How do you write a function?
# What do you do when you encounter an error?
#
# 
#
# Debuggers save you time, and improve your mental model of the language.


using EzXML
using TextAnalysis



"""
    Extract elements of interest from f, an IRS 990 file
"""
function extract_990(f)

    doc = readxml(f) 

    m = findfirst("//Desc/text()", doc)

    if isnothing(m)
        m = findfirst("//IRS990/Description/text()", doc)
    end

    if !isnothing(m) 
        # We found a matching node.
        # Otherwise, `nothing` will come through as the return value of "mission", which indicates that we didn't find anything.
        m = nodecontent(m)
    end

    Dict("file"=>f, "mission"=>m)
end


############################################################

using Debugger
break_on(:error)

files2019 = readdir("2019irs990", join=true)

@run d = map(extract_990, files2019)

@run extract_990(files2019[1])

d = map(extract_990, files2019)

# Key commands: st (status), fr (frame), ` (enter Julia REPL)
#
# Process ALL the files:
@time d = map(extract_990, files2019)
