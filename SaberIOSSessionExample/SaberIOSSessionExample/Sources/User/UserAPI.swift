//
//  UserAPI.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 08/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation
import Alamofire

// @saber.scope(User)
// @saber.cached
class UserAPI {

    private let github: GitHub

    private let sessionManager: UserSessionManager

    // @saber.inject
    init(github: GitHub, sessionManager: UserSessionManager) {
        self.github = github
        self.sessionManager = sessionManager
    }
}

extension UserAPI {

    func getName(completion: @escaping (_ response: DataResponse<String>) -> ()) {
        let url = github.baseURL.appendingPathComponent("/user")
        sessionManager.request(url).responseJSON(queue: DispatchQueue.main) { (response) in
            let mapped: DataResponse<String> = response.flatMap { (value) in
                guard
                    let json = value as? [String : Any],
                    let name = json["login"] as? String else {
                        throw Throwable.runtime("Invalid JSON")
                }
                return name
            }
            completion(mapped)
        }
    }
}
