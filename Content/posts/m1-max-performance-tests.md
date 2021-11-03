---
date: 2021-11-01 12:00
title: M1 Max Xcode Build and Test Benchmarks
description: We’ve run real-world performance benchmarks with the new M1 MacBook Pro machines against M1 and Intel machines.
---

It is a truth universally acknowledged that a developer in possession of a good project must be in [want of a fast compile](https://en.wikiquote.org/wiki/Jane_Austen#Pride_and_Prejudice). First observed some 200 years ago by Jane Austen, this still holds today as we impatiently await the delivery of our new M1 machines.

You’ll have seen benchmarks appearing on [various sites](https://www.anandtech.com/show/17024/apple-m1-max-performance-review) over the last week, but how do these machines stack up with a real-world project?

The Swift Package Index is a sizeable open source project and makes for a decent test when assessing the new chips and so we’ve created [a benchmark tool](https://github.com/SwiftPackageIndex/spi-benchmark) to give some real-world results.

## The Tests

We are testing two performance aspects: building the project (clean build) and running the tests. These tasks might seem similar, but they stress the machine in quite different ways. A clean build will typically utilise all available cores, where this project’s tests use a dockerised database running on the same machine and are not heavily multi-threaded.

First, we’ll start with the build benchmark.

![A chart of build benchmarks showing a dramatic reduction of build times from Intel MacBook Pro machines through to M1-based machines](/images/m1-max-benchmarks-build.png)

Overall, it’s remarkable that the M1 MacBook Air already had the best performance before Apple introduced the new MacBook Pros, but the M1 Pro and Max chips take this further. They improve on the M1 Air’s best result of 47 seconds with a build time of 31 seconds. Those extra cores matter, and the ~35% improvement is in line with what you’d expect, going from a 4+4 performance/efficiency core setup to an 8+2 configuration.

If you're considering upgrading from an Intel machine to an M1 Pro or Max, you'll see a dramatic reduction in build times. It’s been a long time since we’ve seen 2x improvements in a machine of the same class, but the best Intel build time is 60 seconds versus the above mentioned 31 seconds of the M1 Max. That is remarkable.

The results are much less dramatic when running the tests. The M1 Max’s extra cores don’t help much, and the best time between the regular M1 and the Pro/Max is inconsequential. 26.8 seconds on the M1 MacBook Air and 26.3 seconds on the Mac Book Pro.

![A chart of test benchmarks showing a less dramatic steady reduction of test times, but still with Intel MacBook Pro machines being significantly slower than M1-based machines](/images/m1-max-benchmarks-tests.png)

The Intel machines are closer to the Apple silicon machines in this benchmark but still lag by about 50% with their fastest time of 37 seconds.

## M1 Pro vs M1 Max

You may have noticed from the chart that there is no difference between the benchmarks when switching between an M1 Pro and the M1 Max. The GPU is not used for compilation or in these tests so it makes perfect sense, but it's worth mentioning.

It's also worth mentioning that we saw no difference between an M1 Max with 32Gb and one with 64Gb. There are plenty of reasons to get a machine with a Max chip or more memory, but compiling your code faster is not one of them!

## M1 MacBook Air Thermals

If there’s one thing where the MacBook Air is suffering a bit, it’s the sensitivity to a warm environment. The fact that the machine comes without a fan is excellent for its guaranteed silence but leads to a noticeable slow-down when used in warm weather, direct sunshine, or when you are stressing the CPU over extended periods.

You can even see a little of the effect by observing the slight upwards slope of the build benchmarks for the M1 MacBook Air.

![A chart showing just the build benchmarks for the M1-based MacBook Air](/images/m1-macbook-air–build-benchmarks.png)

During the 15 minutes that this benchmark ran for, the machine got quite warm to the touch, and the chart shows that it’s starting to throttle a bit.

## Verdict

If you’re using an Intel machine, even the very fastest ones that Apple ever made, it looks like you can expect your builds to be at least **twice as fast**. Add to that the larger and better screen, the ports, and other minor improvements and this feels like the best upgrade we’ve seen for developers who prefer a laptop in at least a decade.

If you’re on an M1 machine, the performance is less striking as the individual cores on these new chips have almost identical performance, but you’ll still see some improvements due to the increased core count and higher percentage of performance cores.

All of that said, it’s worth remembering one thing, especially if you’re on a tighter budget. The M1 Max MacBook Pro with 64Gb is twice as fast as the fastest Intel machine we tested (30.9 seconds vs 60 seconds) where the M1 MacBook Air is 30% faster than it but for a fraction of the price. The M1 Max MacBook Pros tested here sell for ~$4,000 and the M1 MacBook Air tested here was ~$1,600. The performance definitely does not scale with price. There used to be a time where if you recommended a low-end MacBook to a developer just getting started with Apple development, it would be true that it would be adequate, but it wouldn’t ever be great. That’s no longer true, and even the lowest-end M1 machine will have comparable performance to the highest-end machines.
