//
//  BasicAuthRoutes.swift
//  Application
//
//  Created by Andrew Pleshkov on 24/03/2019.
//

import Foundation
import Kitura
import KituraSession
import Credentials
import CredentialsHTTP

func initializeBasicAuthRoutes(app: App) throws {
    try addDefaultUsers(to: app.container.userStorage)
    app.router.get("/logout") { (request, response, next) in
        try response
            .status(.unauthorized)
            .render("logout.stencil", context: [:])
            .end()
    }
    app.container.authorizer.configure(router: app.router)
}

private func addDefaultUsers(to userStorage: UserStorage) throws {
    try userStorage.register(
        User(id: "admin", name: "Administrator", role: .admin),
        password: "1234"
    )
    try userStorage.register(
        User(id: "john", name: "John Doe", role: .viewer),
        password: "1234"
    )
}
