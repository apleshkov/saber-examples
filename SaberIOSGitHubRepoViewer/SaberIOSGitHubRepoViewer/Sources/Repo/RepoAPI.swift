//
//  RepoAPI.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// @saber.scope(Repo)
// @saber.cached
class RepoAPI {
    
    private let sessionManager: NetworkSessionManager
    
    // @saber.inject
    init(sessionManager: NetworkSessionManager) {
        self.sessionManager = sessionManager
    }
    
    func `public`(since: Int? = nil, completion: @escaping (DataResponse<[Repo]>) -> ()) {
        var params: Parameters = [:]
        if let since = since {
            params["since"] = since
        }
        let request = sessionManager.request("repositories", parameters: params)
        request.responseJSON(queue: DispatchQueue.main) { (response) in
            let parsed: DataResponse<[Repo]> = response.flatMap { (raw) in
                return try JSON(raw).arrayValue.map {
                    return try Repo(json: $0)
                }
            }
            completion(parsed)
        }
    }
    
    func branches(owner: String, repo: String, completion: @escaping (DataResponse<[Branch]>) -> ()) {
        let request = sessionManager.request("repos/\(owner)/\(repo)/branches")
        request.responseJSON(queue: DispatchQueue.main) { (response) in
            let parsed: DataResponse<[Branch]> = response.flatMap { (raw) in
                return try JSON(raw).arrayValue.map {
                    return try Branch(json: $0)
                }
            }
            completion(parsed)
        }
    }
    
    func latestCommit(owner: String, repo: String, branch: String, completion: @escaping (DataResponse<Commit>) -> ()) {
        let request = sessionManager.request("repos/\(owner)/\(repo)/branches/\(branch)")
        request.responseJSON(queue: DispatchQueue.main) { (response) in
            let parsed: DataResponse<Commit> = response.flatMap { (raw) in
                let json = JSON(raw)["commit"]
                return try Commit(json: json)
            }
            completion(parsed)
        }
    }
}

private let dateFormatter = DateFormatter()
