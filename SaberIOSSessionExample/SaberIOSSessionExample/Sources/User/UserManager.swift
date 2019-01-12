//
//  UserManager.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 08/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation
import KeychainAccess

// @saber.scope(App)
// @saber.cached
class UserManager {

    static let didUpdate = Notification.Name("UserManagerDidUpdate")

    private unowned let appContainer: AppContainer

    private let keychain: Keychain

    private(set) var userContainer: UserContainer?

    // @saber.inject
    init(appContainer: AppContainer, keychain: Keychain) {
        self.appContainer = appContainer
        self.keychain = keychain
        if let accessToken = keychain[string: "access_token"] {
            userContainer = makeUserContainer(accessToken: accessToken)
        }
    }
}

extension UserManager {

    func logIn(accessToken: GitHub.AccessToken) {
        set(accessToken: accessToken)
    }

    func logOut() {
        set(accessToken: nil)
    }

    private func set(accessToken: GitHub.AccessToken?) {
        keychain["access_token"] = accessToken
        DispatchQueue.main.async {
            if let accessToken = accessToken {
                self.userContainer = self.makeUserContainer(accessToken: accessToken)
            } else {
                self.userContainer = nil
            }
            NotificationCenter.default.post(name: UserManager.didUpdate, object: nil)
        }
    }

    private func makeUserContainer(accessToken: GitHub.AccessToken) -> UserContainer {
        return UserContainer(appContainer: appContainer, gitHubAccessToken: accessToken)
    }
}
