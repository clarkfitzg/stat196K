Thu Jan 28 10:57:55 PST 2021

Goal: To create an Amazon EC2 image with the basic software and configuration suitable for our class.

Following https://docs.aws.amazon.com/toolkit-for-visual-studio/latest/user-guide/tkv-create-ami-from-instance.html

## Installing software

1. Start with the baseline Amazon Linux 2 AMI.
2. Choose the least powerful instance type you can get away with, to minimize cost.
    It's not obvious to me what [Instance Type](https://aws.amazon.com/ec2/instance-types/) is best for our class.
    I'm going to start small with a general purpose machine and see if we run into problems.
    The t2, t3, t4 cost between $0.04 and $0.05 per vCPU-Hour if set to unlimited mode.
    Do we need unlimited mode?
    Only for batch.
    US East (N. Virginia) where our class will work doesn't have t4g or m6.

The bursting seems to make sense for our use case- sitting down for an afternoon to mess around.
If you're going to run something that takes a long time, then you'll probably want a different machine.

The Spot pricing is a cool model, but not supported by AWS educate.

When I launch, there's an option to connect to Amazon Elastic File System EFS.
The docs say:

> EFS file systems can grow to petabyte scale, drive high levels of throughput, and allow massively parallel access from Amazon EC2 instances to your data.

This is appealing for our use case.
Will students be able to connect to EFS when they launch?

Before launching we see these messages:

> Improve your instances' security. Your security group, launch-wizard-1, is open to the world.

This just means you'll be able to login to the machine from any IP address in the world.
No problem for us.

> Your instance configuration is not eligible for the free usage tier

Got to pay! 💵

Next: create a key pair.
I named mine `key-2020-01-28` to keep it simple and organized.
If I have to create another key on a different date, I'll be able to distinguish them.


Now I'm logging in from the web interface.
Not sure if students can do this.
If they can, then there's no need for SSH right now.

```
Last login: Thu Jan 28 19:53:57 2021 from ec2-18-206-107-25.compute-1.amazonaws.com

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
[ec2-user@ip-172-31-54-193 ~]$ 
[ec2-user@ip-172-31-54-193 ~]$ whoami
ec2-user
[ec2-user@ip-172-31-54-193 ~]$ pwd
/home/ec2-user
[ec2-user@ip-172-31-54-193 ~]$ 
```

Seems to be working fine.
It times out if I leave and come back, similar to SSH.

Commands to install R and python

Fast, small:
```
 sudo amazon-linux-extras install epel
```

around 1 GB:
```
 sudo amazon-linux-extras install R4
```

Then I can access R from the terminal in the normal way.

Similarly for python:
```
sudo amazon-linux-extras install python3.8
```

`python3.8` brings up the latest version of python.

Julia comes from another repo:

```
sudo yum-config-manager --add-repo https://copr.fedorainfracloud.org/coprs/nalimilan/julia/repo/epel-7/nalimilan-julia-epel-7.repo
sudo yum install julia
```

This is enough to save an Amazon Machine Image (AMI) for now.
I'll update it later with some of my configuration.

I've saved it, and updated visibility to Public.
Now lets check if I can access it as a student from AWS Educate.

I found the AMI as a student and started a machine.

Still cannot seem to use the web browser to access the shell, which is quite unfortunate.


```
chmod 400 key-2021-02-28-2.pem
ssh -i "key-2021-02-28-2.pem" root@ec2-35-170-53-159.compute-1.amazonaws.com

# Please login as the user "ec2-user" rather than the user "root".
# 
# Connection to ec2-35-170-53-159.compute-1.amazonaws.com closed.
```

Doesn't like me trying to login as `root`, fair enough.

```
ssh -i "key-2021-02-28-2.pem" ec2-user@ec2-35-170-53-159.compute-1.amazonaws.com
```

Works fine. I'm in, and I see the software that I need.
Sweet!

I also see all my historical commands in `.bash_history`.
Nothing in my `.aws` credentials or config, that's good.
Better be careful to keep it that way!

I can log out completely from everything in the web browser, leave my instance running, and still keep accessing it from SSH.

Amazon Elastic file storage (EFS) seems to require a virtual private cloud (VPC), at least for the basic tutorials.
I have no need for the VPC.
The only advantage to treating something like a file system is convenience.
We're already working with S3 through the publicly available data sets.
It makes sense to stick with S3 for the other stuff that we do.
The other good thing about S3 is that it seems to integrate better with Amazon cloud native tools, like the database stuff.
