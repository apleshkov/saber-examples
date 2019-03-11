//
//  LoggerProvider.swift
//  SaberIOSAbstractLogger
//
//  Created by Andrew Pleshkov on 11/03/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

// @saber.scope(App)
// @saber.cached
class LoggerProvider {

    private let logger: Logger?

    init() {
        #if DEBUG
        self.logger = ConsoleLogger()
        #else
        self.logger = nil
        #endif
    }

    // @saber.provider
    func provide() -> Logger? {
        return self.logger
    }
}
