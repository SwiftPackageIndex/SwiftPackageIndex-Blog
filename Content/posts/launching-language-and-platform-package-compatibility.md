---
date: 2020-08-20 12:00
title: Launching Language and Platform Package Compatibility
description:
---

When we first started thinking about what features a package index might have, being able to quickly and easily see what versions of Swift, and what platforms a package supports was high on our list.

The *simplest* way to get this data is from the [`swiftLanguageVersions`](https://developer.apple.com/documentation/swift_packages/package/3197887-swiftlanguageversions) and [`platforms`](https://developer.apple.com/documentation/swift_packages/package/3197886-platforms) properties of the package manifest, and that’s what we shipped with when we [launched the site back in June](https://iosdevweekly.com/issues/460#start).

The problem is that neither of those properties is perfect. `swiftLanguageVersions` isn’t granular enough, only [officially](https://developer.apple.com/documentation/swift_packages/swiftversion) allowing values of `v4`, `v4_2`, and `v5`. The `platforms` property is better, but doesn’t let package authors declare compatibility with non-Apple operating systems such as Linux.

Wouldn’t it be fantastic if you could see a matrix like this for *every* package? 😍

XXXXXXXX – Screenshot – XXXXXXXX

When we started thinking about how best to solve this problem, the obvious best solution was to build the packages! What better way to see if a package is compatible with Swift 4.2 than to build it with the version of `xcodebuild` that shipped with Xcode 10.1.

So that’s what we did, and it’s available right now. Why not [give it a try](https://swiftpackageindex.com) by searching for a few of your favourite packages? 🚀

### Accurate, real-world compatibility data

It’s a little more complicated than “just build each package” though. A package might build with Swift 5.2 on iOS, but that same build might fail using Swift 5.2 on macOS due to a UIKit dependency, or other macOS specific issue. What’s needed is a *matrix* of builds to generate an accurate picture of compatibility.

So, if we run builds using Swift 5.1 on iOS, macOS, tvOS, watchOS, and with Linux and *any* of them pass, it’s compatible with Swift 5.2. If *any* version of Swift builds without failure on iOS, then the package supports iOS.

We ended up with a platform list of:

* iOS using `xcodebuild`
* macOS using `xcodebuild`
* macOS using `swift build` (there are good reasons where `swift build` would pass in circumstances where `xcodebuild` might fail)
* macOS using `xcodebuild` on Apple Silicon (yes, compiled using a DTK!)
* macOS using `swift build` on Apple Silicon
* tvOS using `xcodebuild`
* watchOS using `xcodebuild`
* Linux using `swift build`

We then decided on a list of Swift compiler versions we’d like to check compatibility with:

* Swift 4.2 (4.2.1)
* Swift 5.0 (5.0.1)
* Swift 5.1 (5.1.3)
* Swift 5.2 (5.2.4)
* Swift 5.3 (beta)

That’s up to 32 builds per package, but that’s just the beginning. What if there’s a stable release and a beta release? The stable version might support Swift 4.2 and higher, and the new beta might drop support for anything less than Swift 5.2. That’s information which would be important when choosing a package, so we need to show it. As we also track the status of the default branch, we must build that too, and we’ve quickly arrived at a place where we might need to 96 builds *per package*! With almost 3,200 packages in the index, that’s potentially more than 300,000 builds! 😅

In practice, it’s less than that as most packages don’t have an active beta release, but it’s still a *lot* of builds. We’ve processed about 200,000 builds as I write this, and we’re not quite done. As of today, we’re at 98% though, so we almost made it before launch! 😬

If you’ve been following [these tweets](https://twitter.com/daveverwer/status/1291808885259620353), it should be obvious what all that processing was! Let’s take a look at the last **30 days** of CPU graphs for our production server, a 2018 Mac mini with 32Gb RAM and a 6-core i7 CPU:

![A graph showing a few spikes of CPU activity, followed by a sustained 100% CPU load.](/images/production-server-thirty-day-cpu-graph.png)

You can see a few of our final test runs in that graph, and then we started processing for real. Since then, we’ve kept the CPU completely pegged for more than two weeks. We’ve also had our staging Mac mini, a spare 2016 MacBook Pro, and a DTK working on builds too.

### Everyone loves badges

Providing compatibility information on this site is one thing, but everyone loves adorning their packages pages with [shields.io](https://shields.io) badges, don’t they? If you maintain an open-source project, wouldn’t you like to show off real compatibility status in your README file, like this?

![A screenshot of a GitHub page with badges that show the Swift and platform compatibility for the package.](/images/rester-readme-with-spi-badges.png)

If you’re a package author, click the “Copy badge” button below each of the compatibility matrices and you’ll have a Markdown image link in your clipboard, ready to use.

Your users will always see live, accurate compatibility information that updates whenever you release a new version.

### Credit where it’s due!

First of all, we’d like to thank our kind friends at [MacStadium](https://macstadium.com) for providing the significant hosting resources for this project as part of their [open-source programme](https://www.macstadium.com/opensource). At one point we were a little concerned that we might melt your machines. We’re glad that we didn’t. They’ve performed incredibly.

We also want to say thank you to [Ankit Aggarwal](https://twitter.com/aciidb0mb3r) and [Boris Bügling](https://twitter.com/neonacho) of Apple. Their tireless help and support on the [SwiftPM Slack](https://swift-package-manager.herokuapp.com) saved us countless hours figuring out the correct way to approach this problem.

Finally, we’d love to say thank you to everyone who provided help and feedback along the way as we built this feature. We couldn’t have done it without any of you.

### Wrapping up

We think that the compatibility data we’ve gathered here is a truly unique resource for this community. Some package authors set up continuous integration for their packages, but typically only with the latest version of Swift.

We believe what we have generated here is unique, and we hope you love it. ❤️