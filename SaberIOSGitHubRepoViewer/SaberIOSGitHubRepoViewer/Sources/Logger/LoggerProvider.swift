//
//  LoggerProvider.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

// @saber.scope(App)
// @saber.cached
class LoggerProvider {
    
    private let logger: Logging?
    
    // @saber.inject
    init() {
        #if DEBUG
        logger = ConsoleLogger()
        #else
        logger = nil
        #endif
    }
    
    // @saber.provider
    func provide() -> Logging? {
        return logger
    }
}
