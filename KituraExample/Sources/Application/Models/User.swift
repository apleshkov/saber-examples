//
//  User.swift
//  Application
//
//  Created by Andrew Pleshkov on 24/03/2019.
//

import Foundation

struct User {
    
    typealias Id = String
    
    enum Role: String {
        case admin
        case viewer
    }
    
    var id: Id
    var name: String
    var role: Role
}
