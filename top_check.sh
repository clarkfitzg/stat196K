
base64 /dev/urandom |
    gzip |
    gunzip |
    grep --ignore-case "clark" |
    head

base64 /dev/urandom |
    sed "s/b/a/" |
    grep --ignore-case "clark" |
    head
