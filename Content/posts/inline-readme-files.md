---
date: 2020-12-24 12:00
title: Inline README Files!
description: Where’s the most important source of information for deciding whether a package is suitable for your needs? It’s in the README file!
---

If you’ve visited the main package index site over the last week or so, you might have noticed something new. Scroll down a little, and you’ll see the README file for the package, right below all the other information that we aggregate.

When considering adding a new feature, at the heart of that decision has to be the question “Does this feature allow people to make better decisions about the package they’re considering?” Rather embarrassingly, the README file is probably *the most* important piece of information when picking a package dependency. Let’s not focus on that though, and be thankful that we finally got around to adding it! 😅

We’re aware of a couple of problems with README files that [contain embedded HTML](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/843) or make use of [in-page anchor links](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/824) that are often used to build a table of contents. We’ll get those fixed over time, but decided that it was worth rolling the feature out even with a couple of remaining issues.

Of course, we’ve not been able to test every single README file, so If you notice any other issues, please let us know by [opening an issue](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/new/choose).

Thank you for all your support this year, and we hope you enjoy this feature that brings our year of development on the Swift Package Index to an end. We have big plans for 2021 though!.
