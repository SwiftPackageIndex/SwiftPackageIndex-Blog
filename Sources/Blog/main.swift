import Foundation
import Publish
import Plot

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
        .deploy(using: .gitHub("SwiftPackageIndex/SwiftPackageIndex-Blog"))
    ]
)
