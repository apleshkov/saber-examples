//
//  ConsoleLogger.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

class ConsoleLogger: Logging {
    
    func log(_ message: @autoclosure () -> String) {
        print(message())
    }
}
