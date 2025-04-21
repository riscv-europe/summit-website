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

## Remove previously downloadded files, if any. Leaving them before a
## new download will have the next ones being numbered by Firefox. And
## this is not what you want!
clobber-imported:
	rm -f $(GDRIVE_DOWNLOAD_DIR)/*.csv

## This done the brutal way because GNU make cannot handle properly
## file names with white spaces.
gdrive-import-downloaded:
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)sessions-config.csv $(GDRIVE_TARGET_DIR)/sessions-config.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_SUMMITCONFIG_BFN)summit-agenda.csv $(GDRIVE_TARGET_DIR)/summit-agenda.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_INVITEDTALKS_BFN)talks-details.csv $(GDRIVE_TARGET_DIR)/talks-details.csv
	cp $(GDRIVE_DOWNLOAD_DIR)/$(GDRIVE_INVITEDTALKS_BFN)panels-details.csv $(GDRIVE_TARGET_DIR)/panels-details.csv

# A couple of shorthands to Jekyll production management.

## To compile and publish the web site on a local web server.
view-site:
	bundle exec jekyll serve

## To properly import and commit the speaker list. 
dos2unix:
	dos2unix $(GDRIVE_TARGET_DIR)/sessions-config.csv
	dos2unix $(GDRIVE_TARGET_DIR)/summit-agenda.csv
	dos2unix $(GDRIVE_TARGET_DIR)/talks-details.csv
	dos2unix $(GDRIVE_TARGET_DIR)/panels-details.csv

data-check: dos2unix
	git diff _data/*.csv

data-commit: dos2unix
	git commit -m "Upd: update summit's databases." _data/*.csv

## To arease the produced site and start producing next time from a
## clean slate.
clean-site:
	rm -rf _site
