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

