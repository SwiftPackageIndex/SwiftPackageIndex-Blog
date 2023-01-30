# Copyright Dave Verwer, Sven A. Schmidt, and other contributors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
