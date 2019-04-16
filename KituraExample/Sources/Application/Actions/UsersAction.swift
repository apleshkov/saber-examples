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
    
    let authorizedUser: AuthorizedUser?
    
    let userStorage: UserStorage
    
    // @saber.inject
    init(authorizedUser: AuthorizedUser?, userStorage: UserStorage) {
        self.authorizedUser = authorizedUser
        self.userStorage = userStorage
    }
    
    func invoke(response: RouterResponse) throws {
        if let authorizedUser = authorizedUser {
            var context = StencilTemplateContext(
                authorizedUser: authorizedUser
            )
            if authorizedUser.role == .admin {
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
