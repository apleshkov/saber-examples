//
//  Repo.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Repo {
    
    var owner: String
    
    var name: String
    
    init(json: JSON) throws {
        owner = json["owner"]["login"].stringValue
        name = json["name"].stringValue
    }
}

extension Repo {
    
    var fullName: String {
        return "\(owner)/\(name)"
    }
}
