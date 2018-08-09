//
//  UserSessionManager.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 08/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation
import Alamofire

typealias UserSessionManager = SessionManager

// @saber.scope(User)
// @saber.cached
class UserSessionManagerProvider {

    private let github: GitHub

    private let accessToken: GitHub.AccessToken

    private let manager: UserSessionManager

    // @saber.inject
    init(github: GitHub, accessToken: GitHub.AccessToken) {
        self.github = github
        self.accessToken = accessToken
        self.manager = {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            config.httpAdditionalHeaders?["Accept"] = "application/vnd.github.v3+json"
            let manager = SessionManager(configuration: config)
            manager.adapter = AccessTokenAdapter(github: github, accessToken: accessToken)
            return manager
        }()
    }

    // @saber.provider
    func provide() -> UserSessionManager {
        return manager
    }
}
