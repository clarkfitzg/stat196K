
# Idea: play around with one command on dummy data to figure out what it does.

# Some dummy data to play with
echo "A
B
B
B
A
A" > ab.txt


uniq ab.txt
# A
# B
# A

uniq --count ab.txt
#      1 A
#      3 B
#      2 A

# Want to count all the A's and B's
cat ab.txt |
    sort |
    uniq --count
#      3 A
#      3 B

# 3.1 should go in bin [3, 4)

echo "3.1" 

