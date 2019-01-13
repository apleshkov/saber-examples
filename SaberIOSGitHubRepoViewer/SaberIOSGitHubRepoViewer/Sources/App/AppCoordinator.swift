//
//  AppCoordinator.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

// @saber.scope(App)
class AppCoordinator {
    
    private let appContainer: AppContainer
    
    private let repoCoordinator: RepoCoordinator
    
    private let navigationController = UINavigationController()
    
    // @saber.inject
    var logger: Logging?
    
    // @saber.inject
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
        self.repoCoordinator = appContainer.repoCoordinator
    }
}

extension AppCoordinator {
    
    func start(with window: UIWindow) {
        logger?.log("[AppCordinator] starting...")
        let rootVC = repoCoordinator.makeRootVC()
        navigationController.setViewControllers([rootVC], animated: false)
        window.rootViewController = navigationController
    }
}
