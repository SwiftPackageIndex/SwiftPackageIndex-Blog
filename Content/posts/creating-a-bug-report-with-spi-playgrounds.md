# Creating a bug report with SPI Playgrounds

Very recently, we’ve released our “SPI Playgrounds” app, which allows you to try out Swift Packages in a Playground in Xcode. It’s a tool to quickly get you up and running with a new package when you’re looking for dependencies.

However, it can also be very helpful when working with dependencies you are already using in your project. One such use-case is creating reproducible bug reports.

You see, it’s often very difficult for open source maintainers to help you when your issue happens in a big app with lots of things having to be set up to reproduce it. This can be particularly difficult for Swift on the server projects, where you might have dependencies like databases and other services.

In order to help maintainers to help you, it’s really critical to prepare something they can run standalone, in a simple fashion. How about in a playground? It doesn’t get much simpler than that.

So when we looked at [one of the issues](https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/1015) in our [Swift Package Index](https://swiftpackageindex.com) project it turned out that this was the perfect opportunity to use Arena to create a playground reproducing the issue.

**Note:** We are using Arena here, which is the underlying tool of “SPI Playgrounds”. You can think of it as the command line version of “SPI Playgrounds” and the reason we’re using it is because it allows you to create a Playgrounds with more than one dependency embedded. “SPI Playgrounds” does not yet support that feature.

The process turned out to be really simple. I started by running Arena as follows:

```bash
arena https://github.com/vapor/vapor https://github.com/vapor/fluent https://github.com/vapor/fluent-postgres-driver -o ssl-error-repro
```

to bring up a playground with Fluent and the Postgres driver.

We knew the issue happened when accessing an Azure Postgres database via TLS, so we set up a test database with a single record and read the record via Fluent.

The whole snippet to reproduce is about 30 lines:

```swift
import Vapor
import Fluent
import FluentPostgresDriver

final class Test: Model, Content {
    static let schema = "test"

    @ID(key: .id)
    var id: UUID?
}

func run() throws {
    let app = Application(.testing)
    defer { app.shutdown() }

    let tlsConfig: TLSConfiguration = .forClient()
    app.databases.use(.postgres(hostname: "pgnio-debug.postgres.database.azure.com",
                                port: 5432,
                                username: "test@pgnio-debug",
                                password: "<ask me for the password>",
                                database: "test",
                                tlsConfiguration: tlsConfig), as: .psql)

    let db = app.db

    let t = try Test.find(UUID("cafecafe-cafe-cafe-cafe-cafecafecafe"), on: db).wait()
    print("t: \(String(describing:  t))")
}

run()
```

In the end it took more time to set up a new test database for the issue.

What’s more, it was very easy from that point on to iterate and try more things as instructed – much easier than it would have been had it still been part of the Swift Package Index server project.

We could have trimmed down the dependencies even further to just PostgresNIO, but using a minimal Vapor setup was the more familiar way to get up and running.

Thanks again to [Fabian Fett](https://twitter.com/fabianfett), [Gwynne Raskind](https://twitter.com/_angeloidbeta) and [Johannes Weiss](https://twitter.com/johannesweiss) for their help and Fabian for the quick turnaround on the fix!
