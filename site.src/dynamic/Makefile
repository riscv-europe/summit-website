POSTERS_PY:=$(shell pwd)/src/posters.py
POSTERS_MD:=$(shell pwd)/../pages/posters.md
POSTERS_PROLOG:=$(shell pwd)/md.prolog/posters.md
POSTERS_CSV:=$(shell pwd)/gdocs/authors-info.csv

.PHONY: posters.md
posters.md: $(POSTERS_MD)

$(POSTERS_MD): $(POSTERS_PY) $(POSTERS_PROLOG) $(POSTERS_CSV)
	cp $(POSTERS_PROLOG) $(POSTERS_MD)
	$(POSTERS_PY) >> $(POSTERS_MD)

