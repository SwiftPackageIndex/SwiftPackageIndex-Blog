default: build

serve-static-site:
	@publish run

build-static-site:
	@publish generate
	
serve-front-end:
	@docker run --rm -it -v $$PWD:/host -w /host --entrypoint sh node:15.8-alpine -c "/usr/local/bin/yarn && /usr/local/bin/yarn serve"
	
build-front-end:
	@docker run --rm -v $$PWD:/host -w /host --entrypoint sh node:15.8-alpine -c "/usr/local/bin/yarn && /usr/local/bin/yarn build"

# The order of these steps is very important. Publish cleans the Output
# directory, so parcel must layer its files on top after Publish finishes.
build: build-static-site build-front-end
	@rm -rf Output/javascripts
	@rm -rf Output/stylesheets

deploy: build
	@publish deploy
