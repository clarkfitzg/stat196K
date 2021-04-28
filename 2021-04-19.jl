using Serialization

termfreq = deserialize("termfreq.jldata")

terms = deserialize("terms.jldata")

# Not exactly what we want...
first10k = 1:10_000

tf10k = termfreq[first10k, :]

termappeared = 0 .< tf10k

word_appearance_count = sum(termappeared, dims = 1)
