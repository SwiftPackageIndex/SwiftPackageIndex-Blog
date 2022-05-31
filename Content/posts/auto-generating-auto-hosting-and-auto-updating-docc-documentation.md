---
date: 2022-06-03 12:00
title: Auto-generating, Auto-hosting, and Auto-updating DocC Documentation
description: We’ve been working on something that should help authors when publishing their package: the easiest way to host your package documentation.
---

Introduced at WWDC 2021, [DocC](https://developer.apple.com/documentation/docc) is Apple’s recommended way to provide package documentation.

It’s easy to use, and the resulting documentation looks great. It generates documentation from documentation comments and article files written in Markdown that suit longer-form documentation. You can even use it to create beautiful interactive tutorials with images and step-by-step instructions. DocC generates either Xcode documentation archives or HTML and CSS files that you can host on a web server.

Of course, once you have a directory full of HTML, that’s only half the battle. You then need to get it hosted and maybe even set up a CI task to handle that task so that your published documentation stays up-to-date as your development progresses.

That’s where our latest feature will come in handy, and we’re launching it today!

## Auto-generated, auto-hosted, and auto-updating

As of today, our build system can now generate and host DocC documentation and make it available from your package’s page in the index.

All we need is a little configuration data so that we know how best to build your docs, and you’ll find a new “Documentation” link in the sidebar.

![A screenshot showing the documentation link on a package page.](/images/documentation-link.png)

As a package author or maintainer, there are only two steps you need to take to have the Swift Package Index host your documentation.

1. Add the [swift-docc-plugin](https://github.com/apple/swift-docc-plugin) documentation plugin to your `Package.swift` manifest file, if you haven’t done so already.
2. Create a `.spi.yml` file and commit it in the root of your package repository telling our build system which targets to build documentation for.

From there, we’ll take care of everything else. Every time you push new commits to your package, we’ll regenerate your documentation.

### Adding the Swift DocC plugin

You may already have taken this first step if you’ve worked with DocC locally. If not, then add the following lines to the end of your `Package.swift` manifest:

```swift
#if swift(>=5.6)
  // Add the documentation compiler plugin if possible
  package.dependencies.append(
    .package(url: “https://github.com/apple/swift-docc-plugin“, from: “1.0.0“)
  )
#endif
```

Making the plugin dependency conditional means that nothing will break even if the `tools-version` of your manifest is for an earlier version of Swift than 5.6.

### Add an Swift Package Index manifest file

Then, create and commit a manifest file named `.spi.yml` file in the root of your repository that looks something like this:

```yaml
version: 1
builder:
  configs:
    - documentation_targets: [Target]
```

This will tell us to generate documentation for the target `Target`. You would normally set this to be your package’s main (or only) target, but it can also be a dedicated target that contains documentation Markdown files.

You can also specify multiple targets, and we’ll add a target switcher in the hosted documentation so people can easily find _all_ your documentation!

## Documentation platform

By default we will generate documentation using macOS. If your package requires the documentation generation to be run for a certain platform, for instance iOS, you can control this by also specifying the platform:

```yaml
version: 1
builder:
  configs:
    - documentation_targets: [Target]
      platform: ios
```

## Auto-updating frequency

To keep the amount of processing we do manageable, we only build the default branch for each package at most once every 24 hours. So, when you push the configuration file live, the system will generate that set of documentation, but will then be 24 hours until generation runs again. If there have been any commits during that period, we’ll generate docs from the latest commit when the period resets.

## Next steps

We’re proud of what we have built here, but there’s more to this feature coming soon.

There’s a full write up of some of the issues we want to tackle [on our Discussion forum](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/discussions/1590#discussioncomment-2784226), but to summarise, this is what we’re planning to work on next:

- Versioned documentation with stable URLs. You’ll be able to read documentation for the exact version of a package that you’re using in your projects.
- Easy switching between documentation versions. We’re planning to make it really clear where the documentation you’re reading has come from. If you’re looking at default branch documentation, you’ll be able to see that. Same if you’re looking at a tagged version. We’ll also make it easy to switch between the different sets of documentation for each package.
