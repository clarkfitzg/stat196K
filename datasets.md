# Data

The classroom accounts are in us-east-1, so I need to store my data there.
Fortunately, 120/208 data sets are available here.

Looking for:

- 10 to 1000 GB of data
- something plain text
- alternative formats, JSON, XML, binary DB
- image data
- easy to understand

Nice to have:

- Freely, publicly available in S3 or other Amazon product.
    Then I don't have to pay for storage! :)
- Ready statistical questions


## AWS Open Data

[Open Data Sponsorship Program](https://aws.amazon.com/opendata/open-data-sponsorship-program/) could pay for storage for 2 years.
Appealing, not that I generate that much data.

[Registry](https://registry.opendata.aws/) shows 208 data sets- not that many.
First few are genomic.

[Facebook population estimate](https://dataforgood.fb.com/docs/high-resolution-population-density-maps-demographic-estimates-documentation/) looks cool.
Table with latitude, longitude, population.
Publicly available in S3.
Could ask some interesting questions:

- What are the most and least densely populated areas in the world?
- What's the population of a region?
- What's the population in a "box"
    This requires efficiently finding the points that are in the box, which will depend on the data organization.

[common crawl](https://commoncrawl.org/2018/03/index-to-warc-files-and-urls-in-columnar-format/) looks like a great way to learn SQL with Amazon Athena.
Arbitrarily large data set, very cool.

[IRS nonprofit 990 forms](https://docs.opendata.aws/irs-990/readme.html) XML

[First Street Foundation Flood risk](https://registry.opendata.aws/fsf-flood-risk/) CSV files.
Certainly relevant to Sacramento with our significant flood risk.

```
~/projects/stat196K $ aws s3 ls s3://first-street-climate-risk-statistics-for-noncommercial-use/ --no-sign-request
                           PRE v1.0/
                           PRE v1.1/
2020-10-06 09:42:25    5908731 FSF_Flood_Model_Technical_Documentation.pdf
2020-09-18 08:53:03        285 LICENSE.txt
```

It looks to me like v1.1 are directories because of the trailing `/`.
We want to find out what kind of data is in here.
We could download and read the document `FSF_Flood_Model_Technical_Documentation.pdf`, or we could attempt to look inside the directories.
Stepping back- we can read the manual, or we can attempt to figure it out for ourselves.
Both are good ideas.

First we need to figure out how to use `aws s3` by [reading the manual](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/ls.html).

```
~/projects/stat196K $ aws s3 ls s3://first-street-climate-risk-statistics-for-noncommercial-use/ --no-sign-request --recursive --human-readable
2020-10-06 09:42:25    5.6 MiB FSF_Flood_Model_Technical_Documentation.pdf
2020-09-18 08:53:03  285 Bytes LICENSE.txt
2020-09-18 06:35:13    0 Bytes v1.0/
2020-09-18 06:37:56   39.5 KiB v1.0/CongDist_level_risk_FEMA_FSF.csv
2020-09-18 06:37:59  508.7 KiB v1.0/County_level_risk_FEMA_FSF.csv
2020-09-18 06:37:54    1.6 KiB v1.0/First Street Aggregate Data Code Book - Congressional District.csv
2020-09-18 06:37:55    2.0 KiB v1.0/First Street Aggregate Data Code Book - County.csv
2020-09-18 06:37:54    2.0 KiB v1.0/First Street Aggregate Data Code Book - Zipcode.csv
2020-09-18 06:37:54  285 Bytes v1.0/LICENSE.txt
2020-09-18 06:38:03    4.0 MiB v1.0/Zip_level_risk_FEMA_FSF.csv
2020-09-18 06:35:25    0 Bytes v1.1/
2020-10-06 09:27:57   74.2 KiB v1.1/CongDist_level_risk_FEMA_FSF_v1.1.csv
2020-10-06 09:27:58  456.7 KiB v1.1/County_level_risk_FEMA_FSF_v1.1.csv
2020-10-06 09:40:32    1.7 KiB v1.1/FSF Aggregate Data CodeBook_v1.1.csv
2020-10-06 09:13:35  285 Bytes v1.1/LICENSE.txt
2020-10-06 09:27:56  906 Bytes v1.1/National_level_risk_FEMA_FSF_v1.1.csv
2020-10-06 09:28:00    4.1 MiB v1.1/Zip_level_risk_FEMA_FSF_v1.1.csv
```

The largest file, besides the documentation, is `4.1 MiB v1.1/Zip_level_risk_FEMA_FSF_v1.1.csv`.
Let's download it to our local machine and look at it.

```
aws s3 cp s3://first-street-climate-risk-statistics-for-noncommercial-use/v1.1/Zip_level_risk_FEMA_FSF_v1.1.csv . --no-sign-request
download: s3://first-street-climate-risk-statistics-for-noncommercial-use/v1.1/Zip_level_risk_FEMA_FSF_v1.1.csv to ./Zip_level_risk_FEMA_FSF_v1.1.csv
```

This command has the form `cp file .`, which means to copy `file` to `.`, where `.` is our current local directory.

Let's verify that we have the file locally:

```
~/projects/stat196K $ ls
AWSCLIV2.pkg                     concepts.md                      schedule.md
README.md                        datasets.md                      thoughts.md
Zip_level_risk_FEMA_FSF_v1.1.csv logistics.md
```


Let's answer some basic EDA questions using the shell.
Why use the shell for this?
To prove how cool we are?

What kind of file is this?

```
```

---

USDA food database

https://fdc.nal.usda.gov/download-datasets.html

This looks to be a good one for introducing databases / relational joins.
