# Will shuf work if the data isn't sorted?
# It seems like it does fine here.
# seq 20 | shuf | shuf --head-count=10

time seq 1e10 | shuf --head-count=10
