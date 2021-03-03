# code style guidelines

- Critique and improve code 



Reading your code taught me new things about Julia, and helped me rewrite my code to improve it.
Thanks!

New test cases:

- `seq 20 | sed "s/1/one/" | julia shuf.jl` shuffles non integer input lines
- `seq 10 | julia shuf.jl 10` shuffles the integers from 1 to 10
- `seq 11 | julia shuf.jl 10` shuffles the integers from 1 to 11
- `time seq 1e9 | julia shuf.jl` shuffles the integers from 1 to 1 billion

123 GO - What's one food that you cooked recently?


## References

- [Basics of the Unix Philosophy](https://homepage.cs.uri.edu/~thenry/resources/unix_art/ch01s06.html)
- [Julia documentation](https://docs.julialang.org/)



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

## Quotes

> Rule of Simplicity: Design for simplicity; add complexity only where you must.

- Eric Raymond


> There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.
> The first method is far more difficult.

- C.A.R. Hoare


> I hate code, and I want as little of it as possible in our product.

– Jack Diederich



## Examples

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


------------------------------------------------------------


DRY Don't repeat yourself.

```julia
if i < sampleSize  #smaller sequence than sample size
    num = Random.shuffle!(num)
    display(num) 
else
    display(num)  
end  
```

123 GO: What is unnecessarily repeated?

There's still a bug here, and we can exercise it with this test:

```
$ seq 11 | julia shuf.jl 10
1
2
3
4
11
6
7
8
9
10
```



------------------------------------------------------------

Choose descriptive variable names.

```julia
args = parse(Int, ARGS[1])

k = parse(Int, ARGS[1])

reservoir_size = parse(Int, ARGS[1])
```

123 GO- what's your favorite?

------------------------------------------------------------

Avoid global variables when possible.
The only global variables you have should be the functions that you define.

```julia
global i = 0
for line in eachline()
    global i += 1
    # ...
```

The way to avoid globals here is to wrap everything up in one function, see demo after class on Monday, Mar 1.

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
