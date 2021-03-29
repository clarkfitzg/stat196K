# Outcomes
#
# 1. Refactor code to remove repetition
# 2. Use `missing` to represent missing values
#
#
# Plan
#
# - Weds functional/parallel programming
# - Fri midterm
# - next week: clustering, dimension reduction
#
#
# 123 GO: What's one word or phrase describing your spring break?


using EzXML


# An interesting DRY example


# Original Code
#############################################################

doc = readxml("contains_Description.xml")


description = findfirst("//MissionDesc", doc)   # first attempt
if isnothing(description)                       # second
	description = findfirst("//Desc", doc)    
end
if isnothing(description)                       # third
	description = findfirst("//Description", doc)    
end    
if isnothing(description)                       # fourth
	description = findfirst("//DescriptionProgramSrvcAccomTxt", doc)
end

# Description Storage Option    
if !isnothing(description)        
	description = nodecontent(description)    
end    
if isnothing(description)         
	description = "No Description Found."    
end


# 
#############################################################
#
# 123 GO: What should our argument be?
#
# 1. the parsed XML 
# 2. the file name?
#
# Does it matter?

"""
    Return the node content for the first xpath string that succeeds, and `missing` otherwise.
"""
try_xpath = function(xpaths, doc)
    for xp in xpaths
        result = findfirst(xp, doc)
        if !isnothing(result)
            # this xp xpath expression worked, we're done
            return nodecontent(result)  # Usually not a good idea to return values in the middle of a function, but no harm here.
        end
    end
    # Nothing found
    missing
end


description = try_xpath(["//MissionDesc", "//Desc", "//Description", "//DescriptionProgramSrvcAccomTxt"], doc)
