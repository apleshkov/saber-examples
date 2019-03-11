//
//  Logger.swift
//  SaberIOSAbstractLogger
//
//  Created by Andrew Pleshkov on 11/03/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

protocol Logger {
    
    func log(_ message: @autoclosure () -> String)
}
