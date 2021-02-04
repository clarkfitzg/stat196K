# My goal is to copy files matching a wildcard from a directory in an S3 bucket into standard output.
# There is a directory containing files in my bucket "stat196k-data-examples".

# Going to work with this bucket, so save to a variable.
bucket="s3://stat196k-data-examples"

aws s3 ls $bucket --recursive

# 2021-02-03 04:25:13          0 -
# 2021-02-03 03:31:08   41328290 20190203.csv
# 2021-02-03 04:28:46   65780184 20190204.csv
# 2021-02-04 15:36:17          6 a.csv
# 2021-02-04 15:36:17          4 a.txt
# 2021-02-04 15:36:17          4 b.txt
# 2021-02-04 15:36:17          6 dir1/a.csv     <-- Let's try to get these two files to appear to stdout
# 2021-02-04 15:36:17          4 dir1/a.txt     <--
# 2021-02-04 15:36:17          4 dir1/b.txt

# Following docs now:
# https://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters

# There are two files matching *.txt at the top level of the bucket.
# We're copying to -, which is stdout

aws s3 cp $bucket - --exclude "*" --include "*.txt"

# download failed: s3://stat196k-data-examples/ to - Parameter validation failed:
# Invalid length for parameter Key, value: 0, valid min length: 1

# ------------------------------------------------------------

# Is the issue with -?
aws s3 cp $bucket ./ --exclude "*" --include "*.txt"

# Nothing happens after this command, no files show up.

# ------------------------------------------------------------

# Perhaps I need the trailing slash to identify it as a "directory"

bucket="s3://stat196k-data-examples/"
aws s3 cp $bucket ./ --exclude "*" --include "*.txt"

# Nope, nothing.

# AHA! Found one error: https://docs.aws.amazon.com/cli/latest/reference/s3/#single-local-file-and-s3-object-operations

# > Some commands perform operations only on single files and S3 objects. The following commands are single file/object operations if no --recursive flag is provided.
# > 
# > cp
# > mv
# > rm

# I'm trying to work on multiple files simultaneously, so I need the --recursive flag

# ------------------------------------------------------------

# Back to the beginning:

aws s3 cp $bucket - --exclude "*" --include "*.txt" --recursive

# > Streaming currently is only compatible with non-recursive cp commands

# Darn.
# So there's no way cp will do what I want.
# Can sync stream?
# No, I don't see any options for streaming.

# My goal with this first assignment is for students to process a stream that's larger than memory, and ideally larger than storage.
# I can accomplish that goal by creating a file in S3 that's as large as I like.
