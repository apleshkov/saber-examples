//
//  Authorizer.swift
//  Application
//
//  Created by Andrew Pleshkov on 25/03/2019.
//

import Foundation
import Kitura
import KituraSession
import Credentials
import CredentialsHTTP

// @saber.scope(App)
// @saber.cached
class Authorizer {
    
    private let userStorage: UserStorage
    
    private let credentials: Credentials
    
    // @saber.inject
    init(userStorage: UserStorage) {
        self.userStorage = userStorage
        self.credentials = Credentials()
        let credentialsPlugin = CredentialsHTTPBasic(verifyPassword: { [weak self] (userId, password, callback) in
            let profile = self?.verifyPassword(userId: userId, password: password)
            callback(profile)
        })
        self.credentials.register(plugin: credentialsPlugin)
    }
    
    private func verifyPassword(userId: String, password: String) -> UserProfile? {
        guard userStorage.check(id: userId, password: password) else {
            return nil
        }
        guard let user = userStorage.find(id: userId) else {
            return nil
        }
        return UserProfile(
            id: user.id,
            displayName: user.name,
            provider: "HTTPBasic"
        )
    }
    
    func configure(router: Router) {
        let session = Session(secret: "AuthSecret", cookie: [CookieParameter.name("Kitura-Auth-cookie")])
        router.all("/", middleware: session)
        router.all("/", middleware: credentials)
    }
}
