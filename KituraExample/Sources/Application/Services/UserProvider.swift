//
//  UserProvider.swift
//  Application
//
//  Created by Andrey Pleshkov on 21.03.2019.
//

import Foundation
import Kitura

// @saber.scope(Request)
// @saber.cached
class UserProvider {
    
    private let user: User?
    
    // @saber.inject
    init(request: RouterRequest, userStorage: UserStorage) {
        if let userId = request.userProfile?.id {
            user = userStorage.find(id: userId)
        } else {
            user = nil
        }
    }
    
    // @saber.provider
    func provide() -> User? {
        return user
    }
}
