
AWS service requirements for STAT 196K

Core experiences for students to have:

- Parallel programming
- Out of memory text stream processing
- SQL queries


I want to use the minimum amount of technology to do this- that will make it simpler for students, and for me.
The first thing to do is see what Amazon actually offers, and which lessons I can build on.
All their information is so marketing oriented, it makes it hard to see what's going on.

My lack of knowledge here could make things interesting.
What is the most efficient way to run a particular data analysis?
The cheapest?
The fastest?
The most reliable?

Take SQL queries.
Amazon Redshift can save SQL results to S3 (Simple Storage Service), which we can presumably then analyze from an EC2.
High performance isn't so important.
More important is ease of use- for example, a GUI to write the queries in.
This means students need to be able to work with S3.
That's a lot.

What about Elastic Map Reduce (EMR)?
EMR conveniently works on data in S3.
It's all based around Hadoop and Spark.
I'm not crazy about either of those tools, since they both have so much overhead.
They're hard to debug and understand.

At a basic level, how do I give students access to data and an EC2 instance?
Here are the ways that I can imagine:

- Directly create users on the EC2 instance, and allow students to login through SSH.
    Pros: Can do anything with SSH, billing shouldn't be an issue
    Cons: More administration for me, 
- Go through Amazon classrooms
    Pros: Students get to have experience of setting up their own EC2 instances
    Cons: Billing might be complicated

What about something like JupyterHub?
If I can run a local SQL server on a single machine, that would eliminate lots of potential problems.

The easiest thing I can imagine is a single server that students log into.
An on demand 32 CPU EC2 server costs between $1.09 and $2.00 per hour.
That's between $2K and $5K to keep it up and running for three months- too expensive.
Also inefficient, because we won't be using them continuously.

In contrast, Amazon Athena you pay *per query*.
This is a far better pricing model for our purposes.

I need to find out if I can allow another user to 

# Keep it local:

https://aws.amazon.com/ec2/pricing/on-demand/

> Data transferred between Amazon EC2, Amazon RDS, Amazon Redshift, Amazon ElastiCache instances and Elastic Network Interfaces in the same Availability Zone is free. 

> Data transferred between Amazon S3, Amazon Glacier, Amazon DynamoDB, Amazon SES, Amazon SQS, Amazon Kinesis, Amazon ECR, Amazon SNS or Amazon SimpleDB and Amazon EC2 instances in the same AWS Region is free.


## AWS Batch


## FSx for Lustre

Shared file system allows many to read simultaneously.

Good- No cost for file transfers within Availability Zone.

Lustre monthly costs:

- $0.041 / GB

Cheapest, and seems best suited to our use typical use cases.

Minimum storage is 1.8 TB.
Hmmm.
Still, $74 / month is not that expensive.

What's with the difference between baseline and burst throughput?
They're more than two orders of magnitude different.


## EFS

Elastic File System

Offers a file system abstraction- good for our class.
Can attach a class full of students simultaneously.

S3 monthly costs:

- $0.30 / GB

No charge for requests, good.

So $300 / month for standard storage.
But I can move it to infrequent access later.

Throughput is 50 KB/s per GB.
If I store 1 TB that's only 50 MB/s, which seems pretty slow.


## S3

Simple Storage

High fault tolerance, available anywhere.
Those are not features I really need.

S3 monthly costs:

- $0.023 / GB storage
- $0.02 / GB transfer

Suppose I store and process 1 TB of data.
Storage in S3 costs $23 / month.


## EBS

Elastic Block Storage

Don't think it will work, because we need more than 16 simultaneous instance connections.

Throughput optimized HDD, associated with throughput optimized EC2 instances.
This sounds much more in line with the class.

EBS monthly costs:

- $0.045 GB

Does this mean that we don't have to pay for each access?
Because that would be sweet.



Definitely

1. Store a large amount of data in S3
2. Students log in and use a running EC2.
    Un

Maybe:

1. lambda
2. Hadoop / Spark
