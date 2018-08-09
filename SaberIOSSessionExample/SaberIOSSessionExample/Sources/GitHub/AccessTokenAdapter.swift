//
//  AccessTokenAdapter.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 08/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess

class AccessTokenAdapter {

    private let github: GitHub

    private let accessToken: GitHub.AccessToken

    init(github: GitHub, accessToken: GitHub.AccessToken) {
        self.github = github
        self.accessToken = accessToken
    }
}

extension AccessTokenAdapter: RequestAdapter {

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(github.host) else {
            return urlRequest
        }
        var request = urlRequest
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
}
