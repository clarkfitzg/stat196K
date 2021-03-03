Code style guidelines

Reading your code taught me new things about Julia, and made me think of better ways to write my own code.
Thanks!

New test cases:

- `seq 20 | sed "s/1/one/" | julia shuf.jl` shuffles non integer input lines
- `seq 10 | julia shuf.jl 10` shuffles the integers from 1 to 10
- `seq 11 | julia travis.jl 10` shuffles the integers from 1 to 11
- `time seq 1e9 | julia shuf.jl` shuffles the integers from 1 to 1 billion



Most did something like this to put a default for the command line argument:

```julia
if isempty(ARGS)
    sampleSize = 100  #default sample size
else
    sampleSize = parse(Int64, ARGS[1])
end
```

The general pattern is `if CONDITION`, where `CONDITION` was one of the following:

```julia
isempty(ARGS)
!isempty(ARGS)
ARGS == []
ARGS != []
length(ARGS) != 0
length(ARGS) == 0
size(ARGS)[1] == 1
length(ARGS) > 0 && length(ARGS[1]) > 0
```

A different approach is to try and catch the exception.

```julia
numRows = 100
try
    numRows = parse(Int, args[1])
catch
end
```

## Good Things

The fastest, most bug free code possible is the code you don't write.

"I hate code, and want as little of it in my product as possible"


------------------------------------------------------------

Organize logic into small functions you can understand, test, and tinker with.

This is the essence of programming.

```julia
function shuf(data=stdin, size=parse(Int, ARGS[1]))
```

```
julia> stream = IOBuffer("""first
       second
       third""")
IOBuffer(data=UInt8[...], readable=true, writable=false, seekable=true, append=false, size=18, maxsize=Inf, ptr=1, mark=-1)

julia> for line in eachline(stream)
       println(line * "!!!!")
       end
first!!!!
second!!!!
third!!!!
```


## Ways to Improve


DRY Don't repeat yourself.

```julia
if i < sampleSize  #smaller sequence than sample size
    num = Random.shuffle!(num)
    display(num) 
else
    display(num)  
end  
```

------------------------------------------------------------

Choose descriptive variable names.

123 GO- what's your favorite?

```julia
args = parse(Int64, ARGS[1])

k = parse(Int64, ARGS[1])
```


------------------------------------------------------------

Avoid global variables when possible.

The way to avoid globals here is to wrap everything up in one function, see demo after class on Monday, Mar 1.

```julia
for line in eachline()
    n = parse(Int64, line)

    # ... do something with n
```


------------------------------------------------------------

Assume as little as possible about your inputs.

```julia
for line in eachline()
    n = parse(Int64, line)

    # ... do something with n
```

------------------------------------------------------------

An important special case: iteration 

```julia
for line in eachline(stdin)
    push!(stream,parse(Int64,line))
end

# ... later ...

selectKItems(stream,n,100)
```

------------------------------------------------------------

Iterate directly over objects, avoiding explicit indexing (like `x[i]`) if possible.

```julia
for i = 1:(size(result, 1))
    print(result[i])
    println()
end
```

------------------------------------------------------------

Learn the idioms of your language.

This takes years of experience and inquisitiveness.

```julia
for tup in enumerate(data)
    i, val = tup[1], tup[2]
```

------------------------------------------------------------

Format your code consistently.

In particular, don't mix tabs and spaces.

    for element in reservoir
    println(element)
  end
