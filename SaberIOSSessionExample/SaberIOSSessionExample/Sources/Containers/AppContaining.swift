//
//  AppContaining.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 02/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import Foundation
import KeychainAccess

class AppExternals {

    let github: GitHub

    let keychain: Keychain = Keychain(service: "GitHub")

    init(github: GitHub) {
        self.github = github
    }
}

// @saber.container(AppContainer)
// @saber.scope(App)
// @saber.externals(AppExternals)
// @saber.threadSafe
protocol AppContaining {}
