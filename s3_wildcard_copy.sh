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



