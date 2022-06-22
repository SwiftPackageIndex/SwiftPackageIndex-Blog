---
date: 2022-06-24
title: Searching for plugins, executable, and libraries
description: We’re adding a new search filter to find packages with certain product types – plugins, executables, libraries
---

Xcode and the Swift Package Manager recently gained a new product type, plugins, and they allow developers to extend their build process with new build commands or build processing steps.

Here are two WWDC 2022 sessions that go into more detail on what plugins are and how you can create them:

- [Meet Swift Package plugins](https://developer.apple.com/wwdc22/110359)
- [Create Swift Package plugins](https://developer.apple.com/wwdc22/110401)

Examples for plugins are [TODO: find actual examples to link to].

Plugins are poised to become powerful tools to exend developers’ build systems and the Swift Package Index is a great place to find them.

This feature was [first suggested to us](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/discussions/1661) by [Joe Heck](TODO: twitter link) and it was thanks to [Marin Todorov’s](https://twitter.com/icanzilb) work that we managed to add this feature so soon after WWDC where Swift Package plugins were officially introduced.
