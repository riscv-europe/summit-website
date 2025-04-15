# Configuration variables

## Firefox's download dir where Google drive files will land.
GDRIVE_DOWNLOAD_DIR?=${HOME}/Downloads

## Base file name from the Google drive spreadsheet whose tabs are
## downloaded as independant CSV files. When saving, Emacs issue a
## warning about SUSPICIOUS LINE CONTINUATIONS. Just say 'y', as
## everything is fine, in fact.
GDRIVE_SUMMITCONFIG_BFN?=Summit-Config\ -\ 
GDRIVE_INVITEDTALKS_BFN?=Invited-Talks-Keynotes\ -\ 

## Target repo. directory for these files.
GDRIVE_TARGET_DIR:=$(shell pwd)/_data


# Import Google drive files downloaded by Firefox.

## Remove previously downloadded files, if any. Or they will be
## numbered by Forefox and you might just overlook them.
gdrive-import-clean:
	rm -f $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)plenary-sessions-config.csv
	rm -f $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)plenary-sessions-agenda.csv
	rm -f $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_INVITEDTALKS_BFN)invited-slots-details.csv

## This done the brutal way because GNU make cannot handle properly
## file names with white spaces.
gdrive-import-downloaded:
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)plenary-sessions-config.csv $(GDRIVE_TARGET_DIR)/plenary-sessions-config.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)plenary-sessions-agenda.csv $(GDRIVE_TARGET_DIR)/plenary-sessions-agenda.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_INVITEDTALKS_BFN)invited-slots-details.csv $(GDRIVE_TARGET_DIR)/invited-slots-details.csv

# A couple of shorthands to Jekyll production management.

## To compile and publish the web site on a local web server.
view-site:
	bundle exec jekyll serve

## To properly import and commit the speaker list. 
data-check:
	dos2unix _data/summit25speakers.csv
	git diff _data/summit25speakers.csv

data-commit:
	dos2unix _data/summit25speakers.csv
	git commit -m "Upd: updated the speakers database." _data/summit25speakers.csv

## To arease the produced site and start producing next time from a
## clean slate.
clean-site:
	rm -rf _site
