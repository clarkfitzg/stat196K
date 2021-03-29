# Outcomes
#
# 1. Refactor code to remove repetition
# 2. Use `missing` to represent missing values
#
#
# Plan
#
# - Weds No class: Cesar Chavez Holiday
# - Fri midterm
# - next week: clustering, dimension reduction, PCA
#
# Study session?
# TODO: Thursday: 12-1, will record
#
# 123 GO: What's one word or phrase describing your spring break?
#
# Midterm:
# - Canvas Quiz
# - 1 hour during this class Friday 12-1
# Multiple choice, matching, fill in the blank, short answer
# All conceptual
#


using EzXML


# An interesting DRY example


# Original Code
#############################################################

doc = readxml("contains_Description.xml")

# Description
# Business name, proxy for size, ...

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


 
#############################################################
#
# Order matters!
#
# 1. Come up with simple example. (TDD) test driven development
# 2. Write a docstring
# 3. Write the function signature (function name and args)
# 4. Implement the actual function so that it passes the test case.
#
# 123 GO: What's our next step?
#
# 123 GO: What should our argument for the document be?
#
# 1. the parsed XML 
# 2. the file name?
#
# Does it matter?
# Yes, it does.
# XML parsing is "expensive" which means it takes a long time.
# Want to avoid doing it multiple times.


"""
    Try several xpath strings, and return the first one that matches the document.
"""
function try_xpath(doc, xpath_strings)
    for xp in xpath_strings
        found_node = findfirst(xp, doc)    
        if !isnothing(found_node)
            # We found a match
            # One way, not necessarily recommended:
            return nodecontent(found_node)
        end
    end
    return missing # statistical missing value
        # same idea as NA in R
end

doc = readxml("contains_Description.xml")

# Can reuse this function for other fields besides mission description.
try_xpath(doc, ["//MissionDesc", "//Desc", "//Description", "//DescriptionProgramSrvcAccomTxt"])

doc2 = readxml("no_Description.xml")

out = try_xpath(doc2, ["//MissionDesc", "//Desc", "//Description", "//DescriptionProgramSrvcAccomTxt"])

# 123 go - is it better to have nothing, or 
# "No Description Found."  # example of sentinel value
# "No xpath matches"
#
# __Sentinel value__ using a particular string to mean something special.

