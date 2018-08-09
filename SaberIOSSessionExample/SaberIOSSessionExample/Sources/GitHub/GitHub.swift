//
//  GitHub.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 06/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation

struct GitHub {

    typealias AccessToken = String

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
