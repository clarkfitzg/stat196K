%.pdf: %.dot
		dot -Tpdf $< -o $@

%.svg: %.dot
		dot -Tsvg $< -o $@
	
get_stats: get_stats.c
	gcc $< -lm -Wall -o get_stats -Ofast
