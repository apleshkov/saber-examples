//
//  AppDelegate.swift
//  SaberIOSAbstractLogger
//
//  Created by Andrew Pleshkov on 11/03/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let appContainer = AppContainer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appContainer.viewController
        window?.makeKeyAndVisible()
        return true
    }
}

