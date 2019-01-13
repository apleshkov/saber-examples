//
//  RepoCoordinator.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

// @saber.scope(App)
class RepoCoordinator {
    
    private let repoContainer: RepoContainer
    
    // @saber.inject
    var logger: Logging?
    
    // @saber.inject
    init(appContainer: AppContainer) {
        self.repoContainer = RepoContainer(appContainer: appContainer)
    }
}

extension RepoCoordinator: RepoListVCDelegate {
    
    func makeRootVC() -> UIViewController {
        let repoListVC = repoContainer.repoListVC
        repoListVC.delegate = self
        repoListVC.title = "Public Repos"
        return repoListVC
    }
    
    func repoListVC(_ repoListVC: RepoListVC, didSelectRepo repo: Repo) {
        logger?.log("[RepoCoordinator] show branch list for \(repo.fullName)")
        let branchListVC = BranchListVC(selectedRepo: repo)
        branchListVC.title = repo.fullName
        repoContainer.injectTo(branchListVC: branchListVC)
        repoListVC.navigationController?.pushViewController(branchListVC, animated: true)
    }
}
