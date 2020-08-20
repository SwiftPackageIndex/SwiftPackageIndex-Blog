//
//  File.swift
//  
//
//  Created by Dave Verwer on 02/08/2020.
//

import Foundation
import Publish

extension Theme {
    static var spi: Self {
        Theme(
            htmlFactory: SPIHTMLFactory(),
            resourcePaths: [
                "Resources/deploy/stylesheets/main.min.css",
                "Resources/deploy/stylesheets/main.min.css.map",
                "Resources/deploy/javascripts/main.min.js",
                "Resources/deploy/javascripts/main.min.js.map",
                "Resources/deploy/images/production-server-thirty-day-cpu-graph.png",
                "Resources/deploy/images/rester-readme-with-spi-badges.png",
                "Resources/deploy/images/logo.svg"
            ]
        )
    }
}
