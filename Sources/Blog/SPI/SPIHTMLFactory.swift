// Copyright 2020-2021 Dave Verwer, Sven A. Schmidt, and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import Publish
import Plot

struct SPIHTMLFactory<Site: Website>: HTMLFactory {

    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .headSPI(for: index, on: context.site),
            .body(
                .developmentBanner(),
                .header(on: context.site),
                .main(on: context.site) { site -> Node<HTML.BodyContext> in
                    .forEach(context.allItems(sortedBy: \.date, order: .descending)) { item in
                        .post(with: item, on: context.site)
                    }
                },
                .footer(on: context.site),
                .developmentBanner()

            )
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .headSPI(for: section, on: context.site),
            .body(
                .developmentBanner(),
                .header(on: context.site),
                .main(on: context.site) { site -> Node<HTML.BodyContext> in
                    .group(
                        .h2("Blog Posts"),
                        .ul(
                            .forEach(context.allItems(sortedBy: \.date, order: .descending)) { item in
                                .li(
                                    .a(
                                        .href(item.path),
                                        .text(item.title)
                                    )
                                )
                            }
                        ),
                        .hr()
                    )
                },
                .footer(on: context.site),
                .developmentBanner()

            )
        )
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .headSPI(for: item, on: context.site),
            .body(
                .developmentBanner(),
                .header(on: context.site),
                .main(on: context.site) { site -> Node<HTML.BodyContext> in
                    .post(with: item, on: context.site)
                },
                .footer(on: context.site),
                .developmentBanner()

            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(.empty)
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }

}
