//
//  NetworkSessionManager.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation
import Alamofire

// @saber.scope(App)
// @saber.cached
class NetworkSessionManager: SessionManager {
    
    private let gitHub: GitHub
    
    // @saber.inject
    init(gitHub: GitHub) {
        self.gitHub = gitHub
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        config.httpAdditionalHeaders?["Accept"] = "application/vnd.github.v3+json"
        super.init(configuration: config)
    }
    
    func request(_ action: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        let url = gitHub.baseURL.appendingPathComponent("/\(action)")
        return super.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
