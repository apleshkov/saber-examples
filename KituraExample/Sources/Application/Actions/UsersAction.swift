//
//  UsersAction.swift
//  Application
//
//  Created by Andrey Pleshkov on 20.03.2019.
//

import Foundation
import Kitura

// @saber.scope(Request)
class UsersAction {
    
    let user: User?
    
    let userStorage: UserStorage
    
    // @saber.inject
    init(user: User?, userStorage: UserStorage) {
        self.user = user
        self.userStorage = userStorage
    }
    
    func invoke(response: RouterResponse) throws {
        if let user = user {
            if user.role == .admin {
                var context = StencilTemplateContext(user: user)
                context.data["users"] = userStorage.allUsers.map {
                    return [
                        "id": $0.id,
                        "name": $0.name,
                        "role": $0.role.rawValue
                    ]
                }
                try response.render("users.stencil", context: context.map).end()
            } else {
                try response.send(status: .forbidden).end()
            }
        } else {
            try response.send(status: .unauthorized).end()
        }
    }
}
