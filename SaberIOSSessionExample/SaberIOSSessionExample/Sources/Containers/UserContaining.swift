//
//  UserContaining.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 08/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation

class UserExternals {

    let accessToken: GitHub.AccessToken

    init(accessToken: GitHub.AccessToken) {
        self.accessToken = accessToken
    }
}

// @saber.container(UserContainer)
// @saber.scope(User)
// @saber.dependsOn(AppContainer)
// @saber.externals(UserExternals)
// @saber.threadSafe
protocol UserContaining {}
