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
                "Resources/deploy/stylesheets/main.min.css.map"
            ]
        )
    }
}
