//
//  UserStorage.swift
//  Application
//
//  Created by Andrey Pleshkov on 20.03.2019.
//

import Foundation
import Dispatch

// @saber.scope(App)
// @saber.cached
// @saber.threadSafe
class UserStorage {
    
    private var users: [User.Id : User] = [:]
    private var passwords: [User.Id : String] = [:]
    private var order: [User.Id] = []
    
    private var queue = DispatchQueue.init(
        label: "UserStorage",
        attributes: [.concurrent]
    )
    
    var allUsers: [User] {
        return order.compactMap { users[$0] }
    }
    
    func register(_ user: User, password: String) throws {
        try queue.sync(flags: [.barrier]) {
            let id = user.id
            guard users[id] == nil else {
                throw Error.alreadyExists(userId: id)
            }
            users[id] = user
            passwords[id] = password
            order.append(id)
        }
    }
    
    func check(id: User.Id, password: String) -> Bool {
        return queue.sync {
            return passwords[id] == password
        }
    }
    
    func find(id: User.Id) -> User? {
        return queue.sync {
            return users[id]
        }
    }
    
    func remove(id: User.Id) throws {
        try queue.sync(flags: [.barrier]) {
            guard users.removeValue(forKey: id) != nil else {
                throw Error.doesNotExist(userId: id)
            }
            guard let idx = order.firstIndex(where: { $0 == id }) else {
                throw Error.doesNotExist(userId: id)
            }
            passwords.removeValue(forKey: id)
            order.remove(at: idx)
        }
    }
}

extension UserStorage {
    
    enum Error: Swift.Error {
        case alreadyExists(userId: User.Id)
        case doesNotExist(userId: User.Id)
    }
}
