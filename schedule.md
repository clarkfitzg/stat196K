# Schedule

The more practice students get on AWS, the better.
I think it makes sense to start out teaching all the basics for AWS, and then use AWS for every subsequent assignment.
AWS skills are more important than Julia, for example.
There are some skills that they could use, but I don't have to emphasize.
For instance, selecting a subset of the data and downloading it to their local machines to use for developing a program.

How to structure the assignments / data sets in terms of increasing complexity?

1. AWS essentials
    1. install local aws client
    1. bash
    1. starting up a machine
    1. client-server, SSH
    1. text editing, configuration files, saving credentials to access S3
    2. git
2. text data - Not too hard to find
    1. downloading a subset of the data (think `head`)
    1. tabular data
    1. processing files line by line
    2. extend the program to work on data larger than memory
    3. single pass algorithms - could be fun to understand and implement a streaming linear regression.
        There's also everything in [OnlineStats](https://joshday.github.io/OnlineStats.jl/latest/)
3. hierarchical data- JSON or XML - IRS 990
3. grouped data - could fit in with one of the other topics, too
4. simulation - No data necessary
    1. profiling
    2. parallelism
5. databases - web archive
    1. SQL
    2. joins - streaming would be fun
6. images / videos - 
    1. processing one file at a time

Stat applications:

1. [reservoir sampling](https://en.wikipedia.org/wiki/Reservoir_sampling) 
    "It can be shown that when the algorithm has finished executing, each item in the input population has equal probability (i.e., {\displaystyle k/n}k/n) of being chosen for the reservoir."
    It would be fun to prove this, but maybe better to just find a proof and have students explain it.


The motivating question at every point will be, "what kind of insight can we gather from this data?"
We're going to start with high level questions- not moving or processing data just for the sake of processing it.

It's not clear to me how long the sessions on these EC2 instances will live for.
My credentials to access S3 seem to disappear in an hour or two.
It's going to be a problem if we have a program that runs for days.
But there are ways around it- no point in worrying now.


