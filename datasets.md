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
