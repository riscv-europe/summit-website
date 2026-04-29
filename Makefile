# Configuration variables

## This is for year 2025.
YEAR=2025

## Firefox's download dir where Google drive files will land.
GDRIVE_DOWNLOAD_DIR?=${HOME}/Downloads

## Base file name from the Google drive spreadsheet whose tabs are
## downloaded as independant CSV files. When saving, Emacs issue a
## warning about SUSPICIOUS LINE CONTINUATIONS. Just say 'y', as
## everything is fine, in fact.
GDRIVE_SUMMITCONFIG_BFN?=Summit-Config\ -\ 
GDRIVE_INVITEDTALKS_BFN?=Invited-Talks-Keynotes\ -\ 

## Target repo. directory for these imported files.
ASIMPORTED_CSV_DIR:=$(shell pwd)/_data/summit$(YEAR)/asimported

## Target repo. directory for these integrated files.
INTEGRATED_CSV_DIR:=$(shell pwd)/_data/summit$(YEAR)/integrated

## Local dir with all the PDF from Softconf' submissions. Defaults to ../
SUBMITTED_PDFS?=$(shell pwd)/../submitted-pdfs

## Where to put the PDF procedings.
PROCEEDINGS_DIR:=summit/$(YEAR)/media/proceedings


# Import 2026 contributions data right from the submission web site.

## The API key to access the submission website is outside of the
## repo., for obvious security reasons. Defaults to the repo's parent
## directory.
PRETALX_APIKEY?=../api.env

## The python script to pull and turn data into CSVs.
PRETALX_IMPORT_PY:=_bin/pretalx-import.py


# Import Google drive files downloaded by Firefox, for Summit 2025.

## Remove previously downloadded files, if any. Leaving them before a
## new download will have the next ones being numbered by Firefox. And
## this is not what you want!
clobber-imported:
	rm -f $(GDRIVE_DOWNLOAD_DIR)/*.csv

## This done the brutal way because GNU make cannot handle properly
## file names with white spaces.
gdrive-import-downloaded:
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)sessions-config.csv $(ASIMPORTED_CSV_DIR)/sessions-config.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)summit-agenda.csv   $(ASIMPORTED_CSV_DIR)/summit-agenda.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)islands-config.csv  $(ASIMPORTED_CSV_DIR)/islands-config.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)posters-agenda.csv  $(ASIMPORTED_CSV_DIR)/posters-agenda.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_INVITEDTALKS_BFN)talks-details.csv   $(ASIMPORTED_CSV_DIR)/talks-details.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_INVITEDTALKS_BFN)panels-details.csv  $(ASIMPORTED_CSV_DIR)/panels-details.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_INVITEDTALKS_BFN)univ-demos.csv      $(ASIMPORTED_CSV_DIR)/univ-demos.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/Submission_Information.csv      		$(ASIMPORTED_CSV_DIR)/summit25posters.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/*.csv



# Integrate information from various CSV files to ease 2025 Summit's
# web site generation.

## Call the integration of all data source for 2025.
integrate:
	mkdir -p _tmp
	_bin/integrate.py \
		--agenda  $(ASIMPORTED_CSV_DIR)/summit-agenda.csv \
		--posters $(ASIMPORTED_CSV_DIR)/posters-agenda.csv \
		--invited $(ASIMPORTED_CSV_DIR)/talks-details.csv \
		--panels  $(ASIMPORTED_CSV_DIR)/panels-details.csv \
		--subm    $(ASIMPORTED_CSV_DIR)/summit25posters.csv \
		--submitted-pdfs $(SUBMITTED_PDFS) \
		--integrated-csvs $(INTEGRATED_CSV_DIR) \
		--published-pdfs $(PROCEEDINGS_DIR) \
		${INTEGRATE_DEBUG} \
		2> integrate.log
	dos2unix $(INTEGRATED_CSV_DIR)/*.csv


# Fetch data from the 2026 web site, intergrate it, and generate CSV
# files for further consumption by the MD-to-HTML Liquid templates of
# the 2026 pages. For obvious security reasons, the key is not stored
# within the public repo. See details above.
pretalx-import:
	( set -a && source $(PRETALX_APIKEY) && set +a && $(PRETALX_IMPORT_PY) --pretty )



# A couple of shorthands to Jekyll production management.

## To compile and publish the web site on a local web server.
view-site:
	bundle exec jekyll serve

## To properly import and commit the speaker list. 
dos2unix:
	dos2unix $(ASIMPORTED_CSV_DIR)/sessions-config.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/summit-agenda.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/islands-config.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/posters-agenda.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/talks-details.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/panels-details.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/univ-demos.csv
	dos2unix $(ASIMPORTED_CSV_DIR)/summit25posters.csv

data-check: dos2unix
	git diff _data/*.csv

data-commit: dos2unix
	git commit -m "Upd: update summit's databases imported from Google drive and/or Softconf." _data/*.csv

## To arease the produced site and start producing next time from a
## clean slate.
clean-site:
	rm -rf _site
