//
//  Branch.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Branch {
    
    var name: String
    
    init(json: JSON) throws {
        name = json["name"].stringValue
    }
}
