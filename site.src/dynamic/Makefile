COPYPDF_PY:=$(shell pwd)/src/import.py
POSTERS_PY:=$(shell pwd)/src/posters.py
POSTERS_MD:=$(shell pwd)/../pages/posters.md
POSTERS_PROLOG:=$(shell pwd)/md.prolog/posters.md

# The CSV database of contributions.

## The repo-local version.
POSTERS_LOC_CSV:=$(shell pwd)/gdocs/authors-info.csv

## Location external to the repository of the CSV download of the
## original Google spreadsheet. The variable defaults to location on
## Christian's Ubuntu VM. Set it as an external shell variable if you
## pîck it from another place.
POSTERS_EXT_CSV?='/media/sf_FromToLinux/RISC-V-Summit-2023/Slides-Posters/poster_sessions.xlsx - Author info.csv'

.PHONY: posters.md-make
posters.md-make: $(POSTERS_MD)

$(POSTERS_MD): $(POSTERS_PY) $(POSTERS_PROLOG) $(POSTERS_LOC_CSV)
	cp $(POSTERS_PROLOG) $(POSTERS_MD)
	$(POSTERS_PY) >> $(POSTERS_MD)

.PHONY: posters.md-commit
posters.md-commit: posters.md-make
	( git commit -m "Fix: auto update of the poster.md page." $(POSTERS_MD) $(POSTERS_PROLOG) $(POSTERS_LOC_CSV) )

# Import into the repository from external location.
.PHONY: import-list
import-list:
	cp $(POSTERS_EXT_CSV) $(POSTERS_LOC_CSV)
	dos2unix $(POSTERS_LOC_CSV)

# Copy over the PDFs into the repo.
.PHONY: import-pdfs
import-pdfs:
	$(COPYPDF_PY)
