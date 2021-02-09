echo "first,last
Brian,Kernighan
Grace,Hopper
Ken,Thompson" > programmers.csv

grep "K" programmers.csv

# ^ matches the beginning of a line.
grep "^K" programmers.csv
