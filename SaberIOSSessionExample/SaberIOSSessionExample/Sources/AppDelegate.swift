//
//  AppDelegate.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 02/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import UIKit
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private(set) lazy var appContainer = AppContainer(
        gitHub: GitHub(
            clientId: ProcessInfo.processInfo.environment["github_client_id"]!,
            clientSecret: ProcessInfo.processInfo.environment["github_client_secret"]!,
            host: "https://api.github.com"
        ),
        keychain: Keychain(service: "GitHub")
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
