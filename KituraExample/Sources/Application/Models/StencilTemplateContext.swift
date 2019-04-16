//
//  StencilTemplateContext.swift
//  Application
//
//  Created by Andrew Pleshkov on 24/03/2019.
//

import Foundation

struct StencilTemplateContext {
    var authorizedUser: AuthorizedUser?
    var data: [String : Any]
    
    init(authorizedUser: AuthorizedUser?, data: [String : Any] = [:]) {
        self.authorizedUser = authorizedUser
        self.data = data
    }
}

extension StencilTemplateContext {
    
    var map: [String : Any] {
        var map: [String : Any] = [
            "data": data
        ]
        if let authorizedUser = authorizedUser {
            map["isLoggedIn"] = true
            map["authorizedUser"] = authorizedUser
        }
        return map
    }
}
