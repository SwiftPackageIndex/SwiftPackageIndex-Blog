---
date: 2022-10-17 12:00
title: Externally hosted package documentation
description: Using auto-hosted documentation remains the easiest way to get your package’s documentation available on the web, but we now also support documentation for projects that have more complex requirements or well-established documentation that already lives on the web.
---

We have a little more documentation-related news to announce today!

We love that so many package authors have chosen to [host their package’s documentation with the Swift Package Index](https://blog.swiftpackageindex.com/posts/auto-generating-auto-hosting-and-auto-updating-docc-documentation/). There are now over 180 packages that have opted in for us to host [versioned documentation](https://blog.swiftpackageindex.com/posts/versioned-docc-documentation/)! We think that’s excellent news for the Swift ecosystem.

We still hope that using our hosted documentation generation is the easiest way to get a package’s documentation hosted on the web. Some projects have more complex requirements or [well-established documentation](https://docs.vapor.codes/) that already lives on the web. So, we’re pleased to announce that the Swift Package Index now supports external documentation!

If you’re a package author and would like to configure your package page to link to your external documentation, add or modify the `.spi.yml` file in your package’s repository root and tell us where to redirect visitors who are looking for documentation.

Here’s how to do it:

```
version: 1
external_links:
  documentation: “https://example.com/package/documentation/”
```

Here’s an [example](https://github.com/groue/GRDB.swift/blob/master/.spi.yml) from [GRDB](https://swiftpackageindex.com/groue/GRDB.swift), who already opted into this new feature.

In terms of what visitors to package pages see, it makes no difference where the documentation Lives. Visitors still see a single “Documentation” link in the package page sidebar.

The final announcement for today is that we now count the presence of documentation (either external or hosted by us) as contributing to our internal package score. We have bigger plans for how we’ll use this package score in the future, but right now, it’s used as part of how we order search results.
