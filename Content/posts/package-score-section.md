---
date: 2023-10-31 12:00
title: Package Score
description: We’ve added a package score section in our package maintainer's page that shows a breakdown of how the score is calculated.
---
This guest post is from Cyndi Chin and announces the results of her work for this year’s Swift Mentorship programme.

Working with Cyndi over the past twelve weeks has been an absolute pleasure. Her enhancements push the Swift Package Index forward by making our internal package ranking algorithm transparent, allowing package authors to understand our search results better.

One of Cyndi’s goals for this programme was to be involved in shipping something from beginning to end, and the end of that process is the announcement of the feature going live on the site! So, I’ll finish by saying a huge thank you to Cyndi for all of her hard work and hand you over to her for the rest of this post so she can make today’s announcement.

--- 

When you search the Swift Package Index, the order in which the search results are displayed is determined by two primary factors: the relevance of text in the package name and description, and an internal score based on various metrics.

Up until now, this score was not visible anywhere on the site, but from today we now  publish it publicly in a new ["Package Score”](https://swiftpackageindex.com/apple/swift-markdown/information-for-package-maintainers#package-score) section on the [Package Maintainer’s page](https://swiftpackageindex.com/apple/swift-markdown/information-for-package-maintainers). We also deployed two additional metrics that contribute to the score.

### What is a package score?
In combination with the relevancy of a search query, we use the package score to partially influence the ordering of search results on the Swift Package Index. This new section gives visibility into how the package score is computed and the metrics it relies on such as whether the package has documentation or not. 

While the algorithm for calculating package scores [has always been publicly available](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/blob/main/Sources/App/Core/Score.swift), it’s unreasonable for us to expect people to browse the source code to see how packages are scored. With today’s release, we aim to make the scoring process more transparent.

### Score traits

The package score is currently evaluated based on 10 score traits. Previously, we relied on 8 attributes to determine a score package.
- Whether the package is archived or not (max +20)
- Whether the package has an open source license that is compatible with the App Store (max +10)
- The number of releases (max +20)
- The number of stars (max +37)
- The number of dependencies (max +5)
- The latest activity (max +15)
- Whether the package has documentation (max +15)
- The number of contributors (max +10)

### Adding new score traits

Along with the introduction of the package score section to the maintainer’s page, we have included two additional score traits in our assessment.

- Whether the package has tests targets (max +5)
- Whether the package has a README file (max +15)

We have updated the package score to consider the presence of test targets and the existence of a README file. Packages receive an additional 5 points for including test targets with the type `test` and an additional 15 points if there is an associated url for the README file.

We recognize that there is room for further improvement and refinement in these areas to make the score more robust and complex. Therefore, this is a starting point and we may twerk these scoring metrics in the future.

### Showing score in the package

While the package score has existed for some time, we are now making this information transparent by surfacing the content in a dedicated section on the package maintainer’s page. It is important for package maintainers to understand their package’s score and the factors that influence it. 

When you visit the package maintainer’s page, there will now be a section similar to the image shown below. This section does not only display the overall package score, but also provides a detailed breakdown, showcasing specific traits that contribute to the final total score calculation.


<picture class="shadow">
  <source srcset="/images/package-score-section~dark.png" media="(prefers-color-scheme: dark)">
  <img src="/images/package-score-section~light.png" alt="The package score section on the package maintainer's page showing a breakdown of the package score.">
</picture>

If you have any suggestions or feedback regarding the package score, we would love to hear your thoughts in our [discussion forum](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/discussions/2591). We appreciate any contributions as we continue to enhance the package score system.

As a final note to this post, I can't express how thankful I am to have had Dave as my mentor in the Swift Mentorship program. Contributing to this project under his guidance has been an incredible learning experience and I'm grateful for the knowledge, support, and inspiration he has provided me. Thank you Dave!
