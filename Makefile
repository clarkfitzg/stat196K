%.pdf: %.dot
		dot -Tpdf $< -o $@

%.svg: %.dot
		dot -Tsvg $< -o $@
