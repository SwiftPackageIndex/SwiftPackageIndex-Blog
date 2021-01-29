//
//  File.swift
//  
//
//  Created by Dave Verwer on 02/08/2020.
//

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
