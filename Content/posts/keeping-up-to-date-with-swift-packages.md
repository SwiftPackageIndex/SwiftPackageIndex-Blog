---
date: 2020-11-25 12:00
title: Keeping Up To Date with Swift Packages
description: How do you keep up with new releases of the packages you use? How do you discover new packages? It’s a tough challenge to keep up to date with everything that the community releases, so we have some announcements today that can help you stay informed!
---

How do you keep up with new releases of the packages you use? How do you discover new packages? It’s a tough challenge to keep up to date with everything that the community releases, so we have some announcements today that can help you stay informed!

### Updates via Twitter

You may already be following the [@SwiftPackages](https://twitter.com/SwiftPackages) account where we tweet occasional updates about the project. But as of yesterday, we’re also tweeting on the [@PackageFirehose](https://packagefirehose) account. As you might guess by the name, this is a high volume account that posts *every time* there’s a new package added to the index, and *every time* there’s a new release of a package that we track. On average, it’s about XXX tweets a day.

![A screenshot of a tweet from the package firehose account.]()

While we’re on the subject of Twitter, I’d love to know what you’d like to see us do with the [@SwiftPackages](https://twitter.com/SwiftPackages) account. I’ve set up a [4 question survey]() if you have a few minutes. We’d love to hear your opinions.

### Updates via RSS

We’ve had RSS support for a while now, but we’ve not talked about it on the blog before, so it’s worth mentioning. If you’d like to keep up to date via a feed reader, or if you’d like more fine-grained control over what type of package updates you’d like to be notified of then subscribe to one of our RSS feeds:

* [New Packages](https://swiftpackageindex.com/packages.rss) – A feed with packages that are new to the Swift Package Index.
* [All Package Releases](https://swiftpackageindex.com/releases.rss) – A feed of all new package version releases.

One advantage that these feeds have over Twitter is that they can be filtered with query string parameters. The package releases feed accepts four parameters; `major`, `minor`, `patch`, and `pre`. Pass `true` to any of these parameters to filter the feed on that part of the [semantic version number](https://semver.org). So, you can subscribe to [only major package release](https://swiftpackageindex.com/releases.rss?major=true), or [major and minor package releases combined](https://swiftpackageindex.com/releases.rss?major=true&minor=true), or if you *only* want to know about pre-release versions, [you can find those here](https://swiftpackageindex.com/releases.rss?pre=true). Use any permutation of the parameters to get exactly the feed that you want.

We hope you find both of these mechanisms for keeping up to date useful!