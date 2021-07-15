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
import CNAMEPublishPlugin

struct Blog: Website {

    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    var url = URL(string: "https://blog.swiftpackageindex.com")!
    var name = "Swift Package Index Blog"
    var description = """
        The Swift Package Index is the place to find Swift packages.
        The project is open-source and community driven, and this blog tells the story of its development.
    """
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try Blog().publish(
    withTheme: .spi,
    additionalSteps: [
        .installPlugin(.generateCNAME(with: "blog.swiftpackageindex.com")),
        .deploy(using: .gitHub("SwiftPackageIndex/SwiftPackageIndex.github.io"))
    ]
)
