//
//  AppDelegate.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let wnd = UIWindow(frame: UIScreen.main.bounds)
        window = wnd
        
        let gitHub = GitHub(
            clientId: ProcessInfo.processInfo.environment["github_client_id"]!,
            clientSecret: ProcessInfo.processInfo.environment["github_client_secret"]!,
            host: "https://api.github.com"
        )
        let appContainer = AppContainer(gitHub: gitHub)
        
        appCoordinator = appContainer.appCoordinator
        appCoordinator.start(with: wnd)
        
        wnd.makeKeyAndVisible()
        return true
    }
}

