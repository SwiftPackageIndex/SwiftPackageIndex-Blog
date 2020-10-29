---
date: 2020-mm-dd HH:MM
title: The Swift Package Index Metadata File
description: …
---

The Swift Package Index collects many pieces of information from various sources to compile its view of Swift packages. We call out to the Github API, we look at git repositories, and we run builds to check for compatibility.

None of this requires any configuration from the package authors – all we need to know is the repository url for your package (Github only, at the moment TODO: Link to Gitlab issue).

This automation is taking us very far but it cannot cover every little detail that package authors may want to express about their packages.

For instance, when we added the build system we quickly encountered packages with watchOS target that would fail to build. The reason was that when Xcode autodiscovers schemes, these are built including tests. This fails, because `XCTest` is not available on watchOS.

The only way to make these package pass their watchOS builds is to add a scheme that builds without tests. Many packages already have such schemes in order to build for watchOS but because authors give these schemes a variety of names it is not possible to discover them (short of applying all sorts of fragile heuristics).

## The `.spi.yml` manifest file

A better way, we believe, is to give package authors a way to tell our build system which scheme to use to build for a particular platform. We support this via a configuration file `.spi.yml` at the root of your Swift package.

### Schemes for watchOS

You can see the popular package [`swift-composable-architecture`][1] by [Pointfree][2] making use of [this config file][3]:

```yaml
version: 1
builder:
  configs:
  - platform: watchos
    scheme: ComposableArchitecture_watchOS
```

Our builders are looking for this file and use the scheme indicated for the given platform. If a platform is not listed we use the default heuristics to determine the scheme as outlined in our [build FAQ][4].

### Images for Linux

Another use case for the `.spi.yml` manifest file is to configure custom base images for our Linux builds.

For our Linux build we run docker commands for various Swift version base images:

```bash
/usr/local/bin/docker run --rm -v "$PWD":/host -w /host swiftlang/swift:5.2.4 swift build --enable-test-discovery
```

This works great except when a package requires an OS level dependency to be available on the system. A common example is OpenSSL.

While we may eventually provide our own set of base images for each supported Swift version, we currently ask package authors whose builds fail with a plain Swift base image to create their own base images for the Swift versions they support.

You will also need to inform us when you do so, because for security reasons we don’t allow arbitrary images and therefore need to add your images to our allow list.

The AWS library [Soto][5] is an example of a package that makes use of this feature in its [`.spi.yml` file][6]:

```yaml
version: 1
builder:
  configs:
  - platform: linux
    swift_version: '5.0'
    image: adamfowlerphoto/aws-sdk-swift:5.0
  - platform: linux
    swift_version: '5.1'
    image: adamfowlerphoto/aws-sdk-swift:5.1
  - platform: linux
    swift_version: '5.2'
    image: adamfowlerphoto/aws-sdk-swift:5.2
  - platform: linux
    swift_version: '5.3'
    image: adamfowlerphoto/aws-sdk-swift:5.3
```

As for the custom schemes, you only need to specify this for Swift versions you are supporting.

## Future direction

The Swift Package Manifest file is in its infancy and we created it to solve issues users were facing when adding supported platforms for their packages.

We expect this file to evolve, which is why it carries a version number. Here are some of the things we are planning to add over time, so that they can be controlled by package authors:

- list of authors, including urls (bio pages, twitter, etc)
- keywords or categories
- home page url
- documentation page url
- funding information/url

There are more things being discussed in [this issue on Github][7]. This is a great place to chime in if you have further suggestions.

## File format

We chose `YAML` as the file format because it is an uncontroversial, universally beloved format that is entirely [free of issues][8] 😬

It is easy to read and edit manually and well supported for parsing from Swift. While it has some downsides as compared to JSON, we believe these aren’t as critical as the upsides and the fact that it supports comments.

Having said that, this file is a proposal and we’ll let adoption be the guide as to how well it is working in practise!

[1]:	https://github.com/pointfreeco/swift-composable-architecture
[2]:	https://www.pointfree.co
[3]:	https://github.com/pointfreeco/swift-composable-architecture/blob/main/.spi.yml
[4]:	https://swiftpackageindex.com/docs/builds#built-how
[5]:	https://swiftpackageindex.com/soto-project/soto
[6]:	https://github.com/soto-project/soto/blob/main/.spi.yml
[7]:	https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/435
[8]:	https://www.arp242.net/yaml-config.html