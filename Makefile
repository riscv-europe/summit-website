# A couple of shorthands to Jekyll production management.

## To compile and publish the web site on a local web server.
view-site:
	bundle exec jekyll serve

## To arease the produced site and start producing next time from a
## clean slate.
clean-site:
	rm -rf _site

