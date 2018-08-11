//
//  AppDelegate.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 02/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private(set) lazy var appContainer = AppContainer(
        appExternals: AppExternals(
            github: GitHub(
                clientId: ProcessInfo.processInfo.environment["github_client_id"] ?? "unknown",
                clientSecret: ProcessInfo.processInfo.environment["github_client_secret"] ?? "unknown",
                host: "https://api.github.com"
            )
        )
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
