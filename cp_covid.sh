# Tue Apr 20 23:11:33 UTC 2021
#
# Goal is to copy data from the AWS COVID-19 data lake in Ohio and make it available in North Virginia so that students can use it.

aws s3 ls s3://covid19-lake/covidcast/json/data/

# Wow, 63 GiB in 1 minute.
# Pretty good.
time aws s3 cp s3://covid19-lake/covidcast/ s3://stat196k-data-examples/covidcast/ --recursive 
