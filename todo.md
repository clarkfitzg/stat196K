One idea 

Next week:

- Monday: shell pipelines
- Wednesday: performance monitoring, tmux?
- Friday: ? stat concept- maybe reservoir sampling?

Streaming `gzip`.

```
echo "hello there" | gzip > hello.txt.gz
```

Explain basic performance measuring tools, like `top`.

Here is after I downloaded 24 GB and uploaded 3.9 GB (gzipped)

```
$ ethtool --statistics eth0
NIC statistics:
     rx_packets: 18870923
     tx_packets: 4346002
     rx_bytes: 25992601102
     tx_bytes: 4465576805
```
