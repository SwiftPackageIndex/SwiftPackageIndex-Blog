---
date: 2021-11-01 12:00
title: M1 Pro/Max Xcode Build and Test Performance
description: We’ve run performance tests with the new M1 Max processor against M1 and Intel machines.
---

It is a truth universally acknowledged, that a developer in possession of a good project, must be in want of a fast compile. First observed some 200 years ago by Jane Austen, this still holds today as we impatiently await the delivery of our new M1 machines: Quite a number of developers have asked for and shared benchmarks for the new machines already.

The Swift Package Index is a sizeable open source project, dare we say good, which should make for a decent test when assessing the M1 Pro and Max and so we’ve created [a little benchmark program](https://github.com/SwiftPackageIndex/spi-benchmark) to do just that.

## The Tests

We are testing two performance aspects: building the project (full build) and running the tests. These tasks differ in that a full build will typically utilise many or all cores of a given machine. The project’s tests, however, while using a dockerised database running on the same machine, are not heavily multi-threaded.

![Build benchmarks](/images/m1-max-benchmarks-build.jpg)

Overall, it’s remarkable that already the M1 MacBook Air was the best performing machine prior to the introduction of the new MacBook Pros. But the M1 Max takes this a step further, at least in the build benchmark. Here, it improves on the M1 Air’s best result of 47 seconds with a build time of 31 seconds. Those extra cores matter, the ~35% improvement is in line with what you would expect going from a 4+4 performance/efficiency core setup to an 8+2 configuration.

If you are considering to upgrade from an Intel machine, you should see the M1 Max fly through your builds. It’s been a long time that we’ve seen 2x improvements in machine of the same class: the best Intel build time is 60 seconds versus the above mentioned 31 seconds of the M1 Max. That is remarkable.

![Build benchmarks](/images/m1-max-benchmarks-tests.jpg)

When running the builds, we can see clearly that we are already using as many cores as we can on the MacBook Air. The M1 Max’ extra cores do not help at all: the Air’s best result of 26.8 seconds is not improved upon with the Max’ 26.3 seconds.

The Intel machines are a bit closer in this benchmark, lagging behind by about 50% with their fastest time of 37 seconds.

## M1 MacBook Air Thermals

If there’s one thing where the MacBook Air is suffering a bit it’s the sensitivity to a warm environment. The fact that the machine comes without a fan is great for its guaranteed silence. But it does lead to a noticeable slow-down when it’s being used in warm weather or direct sunshine – or when you are stressing the CPU over extended periods of time.

You can even see a little of the effect by observing the slight slope of the build test runs. Over the course of the 15 minutes or so this benchmark is running continuously, the machine does get quite warm to the touch and is starting to throttle a bit.

This same benchmark will deteriorate quite noticeably if running with the machine exposed to hot sunlight.

## Verdict

The M1 Air is already a great machine but the new MacBook Pro improves on it in several key aspects for developers: it offers configurations with larger screen sizes, more ports, and it is great to speed up your builds.

And if you are coming from an Intel machine, this improvement on build times should be dramatic.
