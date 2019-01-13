//
//  Logging.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

protocol Logging {
    
    func log(_ message: @autoclosure () -> String)
}
