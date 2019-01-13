//
//  ConsoleLogger.swift
//  SaberIOSLogger
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

// @saber.scope(App)
// @saber.cached
class ConsoleLogger {
    
    func log(_ message: @autoclosure () -> String) {
        print(message())
    }
}
