//
//  File.swift
//  
//
//  Created by Dave Verwer on 08/08/2020.
//

import Foundation

enum Environment {
    case production
    case development

    static var current: Environment {
        guard let environment = ProcessInfo.processInfo.environment["PUBLISH_ENV"]
        else { return .development }  // If no environment variable set, assume development.

        if environment == "production" { return .production }
        else { return .development }
    }
}
