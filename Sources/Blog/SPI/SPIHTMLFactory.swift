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
                .analyticsBody(),
                .developmentBanner(),
                .header(on: context.site),
//                .main(on: context.site),
                .footer(on: context.site),
                .forEach(context.allItems(sortedBy: \.date, order: .descending)) { item in
                    .post(from:item, on:context.site)
                },
                .developmentBanner()

            )
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(.text("Empty"))
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(.text("Empty"))
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(.text("Empty"))
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }

}
