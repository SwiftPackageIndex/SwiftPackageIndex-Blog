default: generate-blog

generate-blog:
	swift run

run: generate-blog
	publish run
