---
date: 2022-06-03 12:00
title: Introducing DocC to the Swift Package Index
description: We’ve been working on something that should help authors when publishing their package: the easiest way to host your package documentation.
---

DocC, introduced at WWDC 2021, is Apple’s recommended way to provide package documentation.

- `TODO looks great`
- `TODO despite some initial updates still a bit tricky to set up for hosting`

[![A screenshot showing a sample documentation page.](/images/documentation-tca.png)](https://swiftpackageindex.com/pointfreeco/swift-composable-architecture/main/documentation/composablearchitecture)

## How does the Swift Package Index help?
We’ve updated our build system to not only build packages but also generate their documentation and make it available from the package page itself. If a package comes with documentation, you can find a link to it in the sidebar.

![A screenshot showing the documentation link on a package page.](/images/documentation-link.png)

There are only two steps you, as the package author, need to take to host your documentation on the Swift Package Index:

1. Add the [swift-docc-plugin][1] documentation plugin to your `Package.swift` manifest file, if you haven’t done so already.
2. Create a `.spi.yml` file in the root of your package repository telling us which targets to build and host documentation for.

### Update your package manifest

The first step you have likely already done if you’ve worked with DocC locally. If not, here is the snippet you can simply add to the end of your `Package.swift` manifest:

```swift
#if swift(>=5.6)
  // Add the documentation compiler plugin if possible
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif
```

You can add this even if the tools-version of your manifest is for an earlier version of Swift than 5.6. The `#if swift(>=5.6)` will make sure it doesn’t interfere with your manifest when run with older Swift versions.

### Add an SPI manifest

The second step is equally simple: Create the following `.spi.yml` file in the root of your repository:

```yaml
version: 1
builder:
  configs:
  - documentation_targets: [Target]
```

This will tell us to generate documentation for the target `Target`. This can (and typically is) your package’s main or only target but it can also be a dedicated target that contains documentation markdown files.

Substitute your target here – or even list several if your documentation is set up to have multiple.

## Documentation platform

By default we are generating documentation on macOS. If your package requires the documentation generation to be run for a certain platform, for instance iOS, you can control this by specifying the platform as well:

```yaml
version: 1
builder:
  configs:
  - documentation_targets: [DocumentationTarget]
    platform: ios
```

## Update frequency

We are building documentation for a package’s default branch as well as any releases. Please note that we collate builds on the default branch over 24 hours in order to reduce the number of builds we have to process for fast-changing repositories.

That means that it will take 24 hours for initial documentation to appear.

## Linking to release documentation

Please also note that we are initially only adding a documentation link to the default branch documentation to the package page even though we are building documentation for releases as well.

If you like, you can still link to release documentation for example from your README by replacing the branch name with the release tag in the URL.

For example, SemanticVersion’s default branch documentation is available at this URL, which we link from the package page:
[https://swiftpackageindex.com/SwiftPackageIndex/SemanticVersion/main/documentation/semanticversion][2]

The documentation for the latest release is available here:
[https://swiftpackageindex.com/SwiftPackageIndex/SemanticVersion/0.3.3/documentation/semanticversion][3]

[1]:	https://github.com/apple/swift-docc-plugin "Swift DocC"
[2]:	https://staging.swiftpackageindex.com/SwiftPackageIndex/SemanticVersion/main/documentation/semanticversion
[3]:	https://swiftpackageindex.com/SwiftPackageIndex/SemanticVersion/0.3.3/documentation/semanticversion