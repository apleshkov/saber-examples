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
    
    let authorizeduser: AuthorizedUser?
    
    let userStorage: UserStorage
    
    // @saber.inject
    init(user: AuthorizedUser?, userStorage: UserStorage) {
        self.authorizeduser = user
        self.userStorage = userStorage
    }
    
    func invoke(response: RouterResponse) throws {
        if let authorizedUser = authorizeduser {
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
