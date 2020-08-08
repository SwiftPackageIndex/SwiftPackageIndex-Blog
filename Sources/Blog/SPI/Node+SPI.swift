//
//  File.swift
//  
//
//  Created by Dave Verwer on 08/08/2020.
//

import Foundation
import Publish
import Plot

let resourceReloadQueryString = String(Int(Date().timeIntervalSince1970))

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
            Path("/main.min.css?" + resourceReloadQueryString)
        ]
        
        let javascriptPaths = [
            Path("/main.min.js?" + resourceReloadQueryString)
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
                <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
                })(window,document,'script','dataLayer','GTM-P3VPPQR');</script>
            """)
        } else {
            return .empty
        }
    }
}

public extension Node where Context == HTML.BodyContext {
    static func analyticsBody() -> Node<Context> {
        if Environment.current == .production {
            return .raw("""
                <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-P3VPPQR"
                height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
            """)
        } else {
            return .empty
        }
    }
    
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
                        .img(.src("/logo.svg")),
                        "Swift Package Index"
                    )
                ),
                .nav(
                    .ul(
                        .li(
                            .a(
                                .href("https://swiftpackageindex.com"),
                                .text("Home")
                            )
                        )
                    )
                )
            )
        )
    }

    static func main<T:Website>(on site: T, content:(T) -> Node<Context>) -> Node <Context> {
        .div(
            .class("inner"),
            content(site)
        )
    }
    
    static func post<T: Website>(from item:Item<T>, on site: T) -> Node<Context> {
        .text(item.title)
    }
    
    static func footer<T: Website>(on site: T) -> Node<Context> {
        .footer(
            .div(.class("inner"),
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
                    .small(
                        .a(
                            .href("https://macstadium.com/"),
                            "Kindly hosted by MacStadium"
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
