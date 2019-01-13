//
//  Repo.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

struct Repo {
    
    var owner: String
    
    var name: String
}

extension Repo {
    
    var fullName: String {
        return "\(owner)/\(name)"
    }
}
