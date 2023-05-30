POSTERS_PY:=$(shell pwd)/src/posters.py
POSTERS_MD:=$(shell pwd)/../pages/posters.md
POSTERS_PROLOG:=$(shell pwd)/md.prolog/posters.md

#The repo-local database file of contributions.
POSTERS_LOC_CSV:=$(shell pwd)/gdocs/authors-info.csv

.PHONY: posters.md-make
posters.md-make: $(POSTERS_MD)

$(POSTERS_MD): $(POSTERS_PY) $(POSTERS_PROLOG) $(POSTERS_LOC_CSV)
	cp $(POSTERS_PROLOG) $(POSTERS_MD)
	$(POSTERS_PY) >> $(POSTERS_MD)

.PHONY: posters.md-commit
posters.md-commit: posters.md-make
	( git commit -m "Fix: auto update of the poster.md page." $(POSTERS_MD) $(POSTERS_PROLOG) $(POSTERS_LOC_CSV) )
