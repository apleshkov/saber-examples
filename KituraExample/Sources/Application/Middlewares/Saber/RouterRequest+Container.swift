//
//  RouterRequest+Container.swift
//  Application
//
//  Created by Andrey Pleshkov on 21.03.2019.
//

import Foundation
import Kitura

private let REQUEST_CONTAINER_USER_INFO_KEY = "@@Saber@@RequestContainer@@"

extension RouterRequest {
    
    var container: RequestContainer {
        get {
            return userInfo[REQUEST_CONTAINER_USER_INFO_KEY] as! RequestContainer
        }
        set {
            userInfo[REQUEST_CONTAINER_USER_INFO_KEY] = newValue
        }
    }
}
