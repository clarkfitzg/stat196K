Going through the EC2 launch process.

Setting up:

- SSH pairs

"Usage hours on your new instances will start immediately and continue to accrue until you stop or terminate your instances."

Like leaving the lights on, or the water running, you pay until you turn it off!

From SSH client:

1. Change permissions for private key.

If you don't, you will see an error like the following:

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0644 for 'clark-student.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "clark-student.pem": bad permissions
ec2-user@ec2-54-172-10-217.compute-1.amazonaws.com: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
```

Can't seem to access data in S3.
Following [this example](https://docs.opendata.aws/irs-990/readme.html):

```
[ec2-user@ip-172-31-93-56 ~]$ aws s3 ls s3://irs-form-990/index --human-readable --summarize
Unable to locate credentials. You can configure credentials by running "aws configure".
```

Principles for trying new technology:

Try the most obvious things first.
If you get an error message that says how to fix it, then try the suggested fix.
Use all the defaults.

I also can't create a new user with an access key from the browser console.
Does this mean I cannot access data in S3?

Unfortunate that tutorials and guides don't work in the restricted Amazon student space.

Finally found the user credentials necessary to access S3- they're in the Vocareum workbench page under account details.


```
[ec2-user@ip-172-31-93-56 ~]$ aws s3 ls s3://irs-form-990/index --human-readable --summarize
2016-07-14 16:21:03   24.6 MiB index_2011.csv
2016-09-27 16:16:08   59.7 MiB index_2011.json
2016-08-05 06:46:28   29.5 MiB index_2012.csv
...
```

From what I can tell, one needs to download the object from S3 into the EC2 instance.
How long does this take?

```
time aws s3 cp s3://irs-form-990/index_2011.csv .
download: s3://irs-form-990/index_2011.csv to ./index_2011.csv

real    0m1.115s
user    0m0.622s
sys     0m0.189s
```

25 MB in about 1 second on the free machine.
That seems excellent.

In contrast, how long does it take from my local machine?

```
time wget http://irs-form-990.s3.amazonaws.com/index_2011.csv

--2021-01-14 16:00:22--  http://irs-form-990.s3.amazonaws.com/index_2011.csv
Resolving irs-form-990.s3.amazonaws.com (irs-form-990.s3.amazonaws.com)... 52.217.13.244
Connecting to irs-form-990.s3.amazonaws.com (irs-form-990.s3.amazonaws.com)|52.217.13.244|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 25748387 (25M) [text/csv]
Saving to: ‘index_2011.csv’

index_2011.csv                                            100%[====================================================================================================================================>]  24.55M   453KB/s    in 39s

2021-01-14 16:01:02 (640 KB/s) - ‘index_2011.csv’ saved [25748387/25748387]

wget http://irs-form-990.s3.amazonaws.com/index_2011.csv  0.07s user 0.42s system 1% cpu 39.643 total
```

25 MB in 40 seconds over the internet to my local machine.



## AMI

Need to set up an AMI for this class.

- git
- tmux
- julia or python
- AWS CLI V2
