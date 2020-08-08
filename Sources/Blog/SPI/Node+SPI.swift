//
//  File.swift
//  
//
//  Created by Dave Verwer on 08/08/2020.
//

import Foundation
import Publish
import Plot

public extension Node where Context == HTML.DocumentContext {
    static func headSPI<T: Website>(for location: Location, on site: T) -> Node<Context> {
        var title = location.title
        if title.isEmpty {
            title = site.name
        } else {
            title.append("&ndash;" + site.name)
        }

        var description = location.description
        if description.isEmpty {
            description = site.description
        }

        let stylesheetPaths = [
            Path("https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"),
            Path("https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&display=swap"),
            Path("/main.min.css")
        ]

        let javascriptPaths = [
            Path("/main.min.js")
        ]

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .forEach(javascriptPaths, { .javascript($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .rssFeedLink(Path.defaultForRSSFeed.absoluteString, title: site.name),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }
}

public extension Node where Context == HTML.HeadContext {
    static func javascript(_ path: Path) -> Node<Context> {
        .script(
            .src(path.absoluteString)
        )
    }
}
