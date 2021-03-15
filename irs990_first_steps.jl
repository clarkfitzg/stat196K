
using EzXML

doc = readxml("201932259349302043_public.xml")

r = root(doc)

# xpath string is "//Desc"
desc = findall("//Desc", r)

nodecontent(desc[4])

# 123 GO- what is the xpath string to find all the AddressLine1Txt?
address = findall("//AddressLine1Txt", r)

# comprehension syntax:
[nodecontent(a) for a in address]

nodecontent(findfirst("//AddressLine1Txt", r))

findfirst("//PreparerUSAddress//AddressLine1Txt", r)

a1 = findall("//PreparerUSAddress//AddressLine1Txt", r)

nodecontent()
