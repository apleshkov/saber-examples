//
//  Commit.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 11/04/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Commit {
    
    var sha: String
    
    var author: Author
    
    var date: Date
    
    var message: String
    
    init(json: JSON) throws {
        let rawDate = json["commit"]["author"]["date"].stringValue
        guard let parsedDate = ISO8601DateFormatter().date(from: rawDate) else {
            throw APIError.message("Invalid date: \(rawDate)")
        }
        date = parsedDate
        author = try Author(json: json["commit"]["author"])
        sha = json["sha"].stringValue
        message = json["commit"]["message"].stringValue
    }
}

extension Commit {
    
    struct Author {
        
        var name: String
        
        var email: String
        
        init(json: JSON) throws {
            name = json["name"].stringValue
            email = json["email"].stringValue
        }
    }
}
