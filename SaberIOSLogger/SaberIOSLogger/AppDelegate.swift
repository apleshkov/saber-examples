//
//  AppDelegate.swift
//  SaberIOSLogger
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let appContainer = AppContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

extension UIApplication {
    
    // Shortcut to get an instance of AppContainer
    var appContainer: AppContainer! {
        return (delegate as? AppDelegate)?.appContainer
    }
}
