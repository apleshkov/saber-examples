//
//  AuthRoutes.swift
//  Application
//
//  Created by Andrew Pleshkov on 24/03/2019.
//

import Foundation
import Kitura
import KituraSession
import Credentials
import CredentialsHTTP

func initializeAuthRoutes(app: Application) throws {
    try app.initDefaultUsers()
    
    let credentials = Credentials()
    let verifyPassword: VerifyPassword = { [weak app] (userId, password, callback) in
        let profile = app?.verifiedUserProfile(userId: userId, password: password, provider: "HTTPBasic")
        callback(profile)
    }
    credentials.register(plugin: CredentialsHTTPBasic(verifyPassword: verifyPassword))
    
    initializeLogoutRoute(app: app)
    let session = Session(secret: "AuthSecret", cookie: [CookieParameter.name("Kitura-Auth-cookie")])
    app.router.all("/", middleware: session)
    app.router.all("/", middleware: credentials)
}

private func initializeLogoutRoute(app: Application) {
    app.router.get("/logout") { (request, response, next) in
        try response
            .status(.unauthorized)
            .render("logout.stencil", context: [:])
            .end()
    }
}


extension Application {
    
    fileprivate func initDefaultUsers() throws {
        let userStorage = container.userStorage
        try userStorage.register(
            User(id: "admin", name: "Administrator", role: .admin),
            password: "1234"
        )
        try userStorage.register(
            User(id: "john", name: "John Doe", role: .viewer),
            password: "1234"
        )
    }
    
    fileprivate func verifiedUserProfile(userId: String, password: String, provider: @autoclosure () -> String) -> UserProfile? {
        let userStorage = container.userStorage
        guard userStorage.check(id: userId, password: password) else {
            return nil
        }
        guard let user = userStorage.find(id: userId) else {
            return nil
        }
        return UserProfile(
            id: user.id,
            displayName: user.name,
            provider: provider()
        )
    }
}
