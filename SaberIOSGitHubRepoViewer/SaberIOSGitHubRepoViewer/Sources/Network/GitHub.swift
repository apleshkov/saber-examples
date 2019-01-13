//
//  GitHub.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation

struct GitHub {
    
    let clientId: String
    
    let clientSecret: String
    
    let host: String
    
    let baseURL: URL
    
    init(clientId: String, clientSecret: String, host: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.host = host
        guard let url = URL(string: host) else {
            fatalError()
        }
        self.baseURL = url
    }
}
