default: build

serve-static-site:
	@publish run

build-static-site:
	@publish generate
	
serve-front-end:
	@docker run --rm -it -v $$PWD:/host -w /host --entrypoint sh node:15.8-alpine -c "/usr/local/bin/yarn && /usr/local/bin/yarn serve"
	
build-front-end:
	@docker run --rm -it -v $$PWD:/host -w /host --entrypoint sh node:15.8-alpine -c "/usr/local/bin/yarn && /usr/local/bin/yarn build"

build: build-static-site build-front-end

deploy: build
	@publish deploy
