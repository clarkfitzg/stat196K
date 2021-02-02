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

---

How about some genomic data?

https://registry.opendata.aws/broad-pan-ukb/

```
aws s3 ls --no-sign-request --summarize --human-readable s3://pan-ukb-us-east-1/

aws s3 ls --no-sign-request --summarize --human-readable --recursive s3://pan-ukb-us-east-1/sumstats_flat_files/
```

6.6 TiB! Whoa that's big enough :)

Let's look at one of them, a 2 GB file.

```
time aws s3 cp --no-sign-request s3://pan-ukb-us-east-1/sumstats_flat_files/prescriptions-zopiclone-both_sexes.tsv.bgz .
```

37 seconds- fast!

take a peek:

```

gzip -l prescriptions-zopiclone-both_sexes.tsv.bgz 

gzip -cd prescriptions-zopiclone-both_sexes.tsv.bgz | head > zopiclone_example.tsv

cut -c-80 zopiclone_example.tsv

```

I have no idea what any of this is, but it looks like the columns correspond to ethnicity.
Ah here: https://pan.ukbb.broadinstitute.org/docs/per-phenotype-files#per-phenotype-files

Really could use a biologist to help out with understanding these.
I'm not even sure what questions we would ask.

------------------------------------------------------------

Global Database of Events, Language and Tone 

Very cool! https://www.gdeltproject.org/

https://registry.opendata.aws/gdelt/

```

# Lots of stuff here
aws s3 ls --no-sign-request --summarize --human-readable s3://gdelt-open-data/v2/events/

# arbitrary day
aws s3 cp --no-sign-request s3://gdelt-open-data/v2/events/20151214143000.export.csv .
```

Looking promising, let's try some Julia.


```
using CSV
using DataFrames

df = CSV.File(20151214143000.export.csv) |> DataFrame
```


Wow, precompiling DataFrames takes a long time, and then fails with this message:

```
julia> using DataFrames
[ Info: Precompiling DataFrames [a93c6f00-e57d-5684-b7b6-d8193f3e46c0]
ERROR: Failed to precompile DataFrames [a93c6f00-e57d-5684-b7b6-d8193f3e46c0] to /home/ec2-user/.julia/compiled/v1.5/DataFrames/AR9oZ_vFGwo.ji.
Stacktrace:
 [1] compilecache(::Base.PkgId, ::String) at ./loading.jl:1305
 [2] _require(::Base.PkgId) at ./loading.jl:1030
 [3] require(::Base.PkgId) at ./loading.jl:928
 [4] require(::Module, ::Symbol) at ./loading.jl:923
 [5] run_repl(::REPL.AbstractREPL, ::Any) at /builddir/build/BUILD/julia/build/usr/share/julia/stdlib/v1.5/REPL/src/REPL.jl:288
```

In a fresh session it still fails.

```
[ec2-user@ip-172-31-90-114 ~]$ julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.5.3 (2020-11-09)
 _/ |\__'_|_|_|\__'_|  |  nalimilan/julia Copr build
|__/                   |

julia> @time using DataFrames
[ Info: Precompiling DataFrames [a93c6f00-e57d-5684-b7b6-d8193f3e46c0]
ERROR: Failed to precompile DataFrames [a93c6f00-e57d-5684-b7b6-d8193f3e46c0] to /home/ec2-user/.julia/compiled/v1.5/DataFrames/AR9oZ_vFGwo.ji.
Stacktrace:
 [1] top-level scope at timing.jl:174
 [2] run_repl(::REPL.AbstractREPL, ::Any) at /builddir/build/BUILD/julia/build/usr/share/julia/stdlib/v1.5/REPL/src/REPL.jl:288
```


Could be an issue with the minimal resources, only 1 vCPU and 1 GB memory.

```
df = CSV.File("20151214143000.export.csv", header = false)
```

This isn't really what I want, think I need DataFrames.
Switching back to R now.

```
d = read.table("20151214143000.export.csv", sep = "\t", nrow = 170)


d[1:10, 45:61]

sapply(d, class)
```

This looks like the dataset for us. 😎

```

aws s3 ls --no-sign-request --summarize --human-readable s3://gdelt-open-data/v2/

```

`events` looks like the most readily accessible table.
Docs: http://data.gdeltproject.org/documentation/GDELT-Event_Codebook-V2.0.pdf


> GDELT Event records are stored in an expanded version of the dyadic CAMEO format,
capturing two actors and the action performed by Actor1 upon Actor2. A wide array of variables break
out the raw CAMEO actor codes into their respective fields to make it easier to interact with the data, 

Docs are easier to read from Google Bigquery: https://console.cloud.google.com/bigquery?p=gdelt-bq&d=gdeltv2&page=table&project=root-clover-288717&t=events

```
SELECT * FROM `gdelt-bq.gdeltv2.events` LIMIT 100
```

Some interesting looking columns:

CameoCode http://data.gdeltproject.org/documentation/CAMEO.Manual.1.1b3.pdf

code events according to three levels of detail.
Here's one example:

> CAMEO 015
> Name Acknowledge or claim responsibility
> Description Non-apologetically claim responsibility, admit an error or wrongdoing, or
> retract a statement without expression of remorse.
> Usage Notes This event form is a verbal act. Remorseful acknowledgements should be
> coded as ‘Apologize’ (055) instead.
> Example A Damascus-based Palestinian guerrilla group claimed responsibility on Saturday for attacks on Israeli troops from Jordan in the past two days.

Some numeric columns:

> GoldsteinScale. (floating point) Each CAMEO event code is assigned a numeric score from -10 to
> +10, capturing the theoretical potential impact that type of event will have on the stability of a
> country. This is known as the Goldstein Scale. This field specifies the Goldstein score for each
> event type. NOTE: this score is based on the type of event, not the specifics of the actual event
> record being recorded – thus two riots, one with 10 people and one with 10,000, will both
> receive the same Goldstein score. This can be aggregated to various levels of time resolution to
> yield an approximation of the stability of a location over time.

> AvgTone. (numeric) This is the average “tone” of all documents containing one or more
> mentions of this event during the 15 minute update in which it was first seen. The score
> ranges from -100 (extremely negative) to +100 (extremely positive). Common values range
> between -10 and +10, with 0 indicating neutral. This can be used as a method of filtering the
> “context” of events as a subtle measure of the importance of an event and as a proxy for the
> “impact” of that event. For example, a riot event with a slightly negative average tone is likely
> to have been a minor occurrence, whereas if it had an extremely negative average tone, it
> suggests a far more serious occurrence. 

Kinds of questions we could do:

1. Count up events of interest- location or type of event.
1. Create a histogram of one of these numeric columns.
1. How many data files are here?
2. What time period does this data cover?

Other requirements:

1. Read the documentation, figure out what some of these things mean.
1. Process more data than your 8 GB of hard drive.

Can we download files according to time?

```
# Nope!
# aws s3 ls --no-sign-request --summarize --human-readable s3://gdelt-open-data/v2/events/2015*
```

[Dirty hack](https://github.com/aws/aws-cli/issues/3784#issuecomment-607811701)

```
aws s3 sync --no-sign-request --dryrun --exclude '*' --include '2015*' s3://gdelt-open-data/v2/events/ ./
```

I believe each file corresponds to 15 minutes.
So `"20151214143000.export.csv"` is December 14, 2015 at 2:30 PM.

- 2015 year
- 12 month
- 14 day
- 14 hour
- 30 minutes
- 00 seconds
