# One day was between 40 and 60 MB.
# So one month should be around 1500 MB, or 1.5 GB.
# To get more than 8 GB, I'll need at least 6 months.
# Download from S3 speed is around 30 MB/sec.
# Then it will take 8000/30 around 270 seconds or less than 5 minutes to stream 8 GB.
# No problem.
# I might as well do a full year then.
#
# I wonder if AWS allows streaming a compressed file?
# Appears so, I'll try.
#
# M4 xlarge instances have "high" network capacity, compared to "Low to Moderate" for the t2.micro we've been using.
# They also cost $0.20 / hour, about 15 times as much as the t2.micro.
# Let's see how fast they are.
#
# Seems like it's cruising along at around 62-63 MiB/s, which is not that much better.


# Download GDELT files for this day and upload them to S3
DATE="2018"
BUCKET="stat196k-data-examples"

# Copy from public source into temporary directory
mkdir ${DATE}
time aws s3 sync s3://gdelt-open-data/v2/events/ ${DATE} --exclude "*" --include "${DATE}*"
# real    7m12.398s
# Copies 24 GB of data, so bandwidth is around 55 MB/s

# Put them all in one object and streaming upload from standard input
# No need for --expected-size flag, because file size is < 50 GB
time cat ${DATE}/* |
    gzip |
    aws s3 cp - s3://${BUCKET}/${DATE}.csv.gz

# We might get a little pipeline parallelism here.
#
# $ top
#
#   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
#  3807 ec2-user  20   0    4496   1464   1180 R  98.0  0.0   0:34.00 gzip
#  3809 ec2-user  20   0 1173572 102536  10984 S   5.0  0.6   0:02.77 aws
#  3806 ec2-user  20   0  115832   2116    756 S   3.3  0.0   0:01.30 cat
#
# Nope, it appears that gzip is too much of a bottleneck, with %CPU at 98.0.
#
# Maybe we can try pigz for a parallel implementation

# Quick sanity check before I turn this instance off and delete everything.

aws s3 cp s3://${BUCKET}/${DATE}.csv.gz - | gunzip | head > first10.txt

# Yep, looks good.


# clean up
rm -r $DATE
