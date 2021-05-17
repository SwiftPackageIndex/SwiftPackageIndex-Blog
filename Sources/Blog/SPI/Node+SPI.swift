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

        // The generation date of the site, so the CSS is never out of date.
        let resourceReloadQueryString = String(Int(Date().timeIntervalSince1970))

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .stylesheet(Path("/main.css?" + resourceReloadQueryString)),
            .javascript(Path("/main.js?" + resourceReloadQueryString)),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .rssFeedLink(Path.defaultForRSSFeed.absoluteString, title: site.name),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            }),
            .analyticsHead()
        )
    }
}

public extension Node where Context == HTML.HeadContext {
    static func javascript(_ path: Path) -> Node<Context> {
        .script(
            .src(path.absoluteString)
        )
    }
    
    static func analyticsHead() -> Node<Context> {
        if Environment.current == .production {
            return .raw("""
            <script async defer data-domain="blog.swiftpackageindex.com" src="https://plausible.io/js/plausible.outbound-links.js"></script>
            <script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>
            """)
        } else {
            return .empty
        }
    }
}

public extension Node where Context == HTML.BodyContext {
    static func developmentBanner() -> Node<Context> {
        if Environment.current != .production {
            return .div(
                .class("development"),
                .text("Development")
            )
        } else {
            return .empty
        }
    }
    
    static func header<T: Website>(on site: T) -> Node<Context> {
        .header(
            .div(
                .class("inner"),
                .a(
                    .href("/"),
                    .h1(
                        .img(.src("/images/logo.svg")),
                        "The Swift Package Index Blog"
                    )
                ),
                .nav(
                    .a(
                        .href("https://swiftpackageindex.com"),
                        .text("Visit the Swift Package Index")
                    )
                )
            )
        )
    }

    static func main<T:Website>(on site: T, content:(T) -> Node<Context>) -> Node <Context> {
        .main(
            .div(
                .class("inner"),
                content(site),
                .whatIsTheSPI()
            )
        )
    }
    
    static func post<T: Website>(with item:Item<T>, on site: T) -> Node<Context> {
        .group(
            .h2(
                .class("post"),
                .a(
                    .href(item.path),
                    .text(item.title)
                )
            ),
            .small(
                "Posted ",
                .a(
                    .href(item.path),
                    .text(dateFormatter.string(from: item.date))
                ),
                "."
            ),
            .element(named: "hr", nodes:[
                .attribute(named: "class", value: "post")
            ]),
            .contentBody(item.content.body),
            .hr()
        )
    }

    static func whatIsTheSPI() -> Node<Context> {
        .div(
            .class("what"),
            "The ",
            .a(
                .href("https://swiftpackageindex.com"),
                "Swift Package Index"
            ),
            " is a search engine for Swift packages with one goal. ",
            .strong("To help you make better decisions about dependencies."),
            " For more information, the best place to start is with the ",
            .a(
                .href("https://swiftpackageindex.com/faq"),
                "Frequently Asked Questions"
            ),
            "."
        )
    }

    static func footer<T: Website>(on site: T) -> Node<Context> {
        .footer(
            .div(
                .class("inner"),
                .nav(
                    .ul(
                        .li(
                            .a(
                                .href("https://swiftpackageindex.com/privacy"),
                                "Privacy and Cookies"
                            )
                        ),
                        .li(
                            .a(
                                .href("https://twitter.com/swiftpackages"),
                                "Twitter"
                            )
                        )
                    ),
                    .p(
                        .a(
                            .href("https://github.com/sponsors/SwiftPackageIndex"),
                            "Please consider supporting this project"
                        )
                    ),
                    .small(
                        .text("Kindly hosted by"),
                        .a(
                            .href("https://macstadium.com/"),
                            "MacStadium"
                        )
                    )
                )
            )
        )
    }
    
    static func small(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "small", nodes: nodes)
    }
}

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateStyle = .full
    return dateFormatter
}()
