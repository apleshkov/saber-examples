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

extension RepoCoordinator {
    
    func makeRootVC() -> UIViewController {
        let repoListVC = repoContainer.repoListVC
        repoListVC.delegate = self
        repoListVC.title = "Public Repos"
        return repoListVC
    }
}

extension RepoCoordinator: RepoListVCDelegate {
    
    func repoListVC(_ repoListVC: RepoListVC, didSelectRepo repo: Repo) {
        logger?.log("[RepoCoordinator] show branch list for \(repo.fullName)")
        let branchListVC = repoContainer.branchListVCFactory.make(repo)
        branchListVC.delegate = self
        branchListVC.title = repo.fullName
        repoListVC.navigationController?.pushViewController(branchListVC, animated: true)
    }
}

extension RepoCoordinator: BranchListVCDelegate {
    
    func branchListVC(_ branchListVC: BranchListVC, didSelectRepo repo: Repo, branch: Branch) {
        logger?.log("[RepoCoordinator] show lastest commit for \(branch.name)")
        let commitVC = repoContainer.latestCommitVCFactory.make(repo, branch)
        branchListVC.navigationController?.pushViewController(commitVC, animated: true)
    }
}
