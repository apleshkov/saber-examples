//
//  Throwable.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 08/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation

enum Throwable {
    case runtime(String)
}

extension Throwable: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .runtime(let msg):
            return msg
        }
    }
}
