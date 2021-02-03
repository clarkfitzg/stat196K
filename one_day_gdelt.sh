#!/bin/bash

# Download GDELT files for this day and upload them to S3
DATE="20190204"
BUCKET="stat196k-data-examples"

# Copy from public source into temporary directory
mkdir ${DATE}
aws s3 sync s3://gdelt-open-data/v2/events/ ${DATE} --exclude "*" --include "${DATE}*"

# Put them all in one object and streaming upload from standard input
cat ${DATE}/* | aws s3 cp - s3://${BUCKET}/${DATE}.csv

# clean up
rm -r $DATE
