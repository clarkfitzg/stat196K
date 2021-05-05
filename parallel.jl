
# Not quite enough to run, but getting the idea.

import Distributed

files2019 = readdir("/home/ec2-user/2019", join=true)

#------------------------------------------------------------
# Outcomes:
#
# - convert a `map()` into a parallel version
# - determine if a program is *actually* parallel
#
# 123 GO - What's your favorite food to buy at the grocery store?
#------------------------------------------------------------

# Serial version
# 182 seconds when we ran it the first time.
# 63 seconds when we ran it again later.
@time d = map(extract_990, files2019)

# Start julia with 
# $ julia -p 8
# p is for the number of processes

# prepare all the workers
Distributed.@everywhere include("990.jl")

# replace `map` with `Distributed.pmap`
# 11.8 seconds
# 41.9 seconds if we clear the files from the memory cache
@time d = Distributed.pmap(extract_990, files2019)

# 12.2 seconds
@time d2 = Distributed.pmap(extract_990, files2019, batch_size = 100)

# It seems like we got a 15x speedup!
# But we only used 8 parallel processes????!!
# Some bottleneck is no longer there?
# It was from the files being cached in memory.
#
# Suppose we take all the files OUT of memory.
# Will the parallel version then also take close to 182 seconds?
# If it does, it means that parallelism cannot help us if we load from a file that isn't cached in memory.
