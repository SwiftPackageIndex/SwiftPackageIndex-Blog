---
date: 2022-06-06 12:00
title: Auto-generating, Auto-hosting, and Auto-updating DocC Documentation
description: DocC is Apple’s recommended way to provide documentation for your packages, and launching today, the
Swift Package Index will generate, host, and update all package documentation!
---

Introduced at WWDC 2021, [DocC](https://developer.apple.com/documentation/docc) is Apple’s recommended way to provide documentation for your packages.

It’s easy to use, and the resulting documentation looks great. It generates documentation either from comments or separate article files written in Markdown that is more suitable for longer-form documentation. You can even use it to create beautiful interactive tutorials with images and step-by-step instructions. DocC generates either an Xcode documentation archive or a set of HTML and CSS files that you can host on a web server.

Of course, having a directory full of HTML is only half the battle. Your next task is to get it hosted somewhere online and maybe even set up a CI task to automate that process so that your published documentation stays up-to-date as your development progresses.

That’s where our latest feature will come in handy, and we’re launching it today!

## Auto-generated, auto-hosted, and auto-updating

Our build system can now generate and host DocC documentation and make it available from your package’s page in the index. All we need is a little configuration data so that we know how best to build your docs.

Once configured, you will see a new “Documentation” link in the sidebar and never have to worry about your documentation ever again!

![A screenshot showing the documentation link on a package page.](/images/documentation-link.png)

As a package author or maintainer, there are only three things you need to do for the Swift Package Index to build and host your documentation.

1. Ensure that your package builds successfully with Swift 5.6. Your package can support earlier versions of Swift, too, but must successfully build with 5.6.
2. Add the [swift-docc-plugin](https://github.com/apple/swift-docc-plugin) documentation plugin to your package’s `Package.swift` manifest file, if you haven’t done so already.
3. Create a `.spi.yml` file and commit it to the root of your package’s repository, telling our build system which targets have documentation.

From there, we’ll take care of everything else. Every time you push new commits to your package, we’ll regenerate your documentation.

### Adding the Swift DocC plugin

You may already have taken this first step if you’ve worked with DocC locally. If not, then add the following lines to the end of your `Package.swift`:

```swift
#if swift(>=5.6)
  // Add the documentation compiler plugin if possible
  package.dependencies.append(
    .package(url: “https://github.com/apple/swift-docc-plugin“, from: “1.0.0“)
  )
#endif
```

Making the plugin dependency conditional means that nothing will break even if the `tools-version` of your manifest is for an earlier version of Swift than 5.6. Naturally, if your package _only_ supports Swift 5.6 and above, this is unnecessary.

### Add a Swift Package Index manifest file

Then, create and commit a manifest file named `.spi.yml` file in the root of your repository that looks something like this:

```yaml
version: 1
builder:
  configs:
    - documentation_targets: [Target]
```

This file tells our build system to generate documentation for the target `Target`. You would typically set this as your package’s main (or only) target, but it may also be a dedicated target containing documentation Markdown files.

You can also specify multiple targets, and we’ll add a target switcher in the hosted documentation so people can easily find _all_ your documentation!

## Documentation platform

By default, we will generate documentation using macOS. If your package requires the documentation generation to be run for a certain platform such as iOS, you can also specify a platform:

```yaml
version: 1
builder:
  configs:
    - platform: ios
    documentation_targets: [Target]
```

## Auto-updating frequency

To keep the amount of processing that our build servers perform under control, we only build the default branch for each package at most once every 24 hours. So, when you push the configuration file live, the system will generate that set of documentation, but it will then be 24 hours until the generation process runs again. If there have been any commits during that period, we’ll create docs from the latest commit when the period resets.

## Early adopters!

You may have seen a [call for package authors with DocC compatible documentation](https://twitter.com/SwiftPackages/status/1531299947462676480) earlier this week, and I’m thrilled to say that we have over XXX packages that have already added configuration files and have their documentation hosted by us! Why not check them out?

- Documentation for [Package X](https://swiftpackageindex.com/package/x)
- Documentation for [Package Y](https://swiftpackageindex.com/package/x)

If you maintain one of the 4,600+ packages we have in the index, add your configuration file, and we’ll take care of the rest.

## Next steps

We’re proud of what we have built here, but we're not done with this feature yet.

There’s a full write up of things we want to tackle [on our Discussion forum](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/discussions/1590#discussioncomment-2784226), but to summarise, this is what we’re planning to work on next:

- Versioned documentation with stable URLs. You’ll be able to read documentation for the exact version of a package you’re using in your projects.
- Easy switching between documentation versions. We’re planning to make it clear where the documentation you’re reading has come from. If you’re looking at default branch documentation, you’ll be able to see that. Same if you’re looking at a tagged version. We’ll also make it easy to switch between documentation sets for each package.
