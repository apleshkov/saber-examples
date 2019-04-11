//
//  StencilTemplateContext.swift
//  Application
//
//  Created by Andrew Pleshkov on 24/03/2019.
//

import Foundation

struct StencilTemplateContext {
    var user: User?
    var data: [String : Any]
    
    init(user: User?, data: [String : Any] = [:]) {
        self.user = user
        self.data = data
    }
}

extension StencilTemplateContext {
    
    var map: [String : Any] {
        var map: [String : Any] = [
            "data": data
        ]
        if let user = user {
            map["isLoggedIn"] = true
            map["user"] = user
        }
        return map
    }
}
