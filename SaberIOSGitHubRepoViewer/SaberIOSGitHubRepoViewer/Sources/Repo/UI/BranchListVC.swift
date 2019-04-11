//
//  BranchListVC.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

// @saber.scope(Repo)
class BranchListVCFactory {
    
    let make: (_ selectedRepo: Repo) -> BranchListVC
    
    // @saber.inject
    init(repoAPI: RepoAPI, logger: Logging?) {
        make = { (selectedRepo) in
            return BranchListVC(
                selectedRepo: selectedRepo,
                repoAPI: repoAPI,
                logger: logger
            )
        }
    }
}

class BranchListVC: UIViewController {
    
    private let repoAPI: RepoAPI
    
    private let logger: Logging?
    
    private let selectedRepo: Repo
    
    private var list: [Branch] = []
    
    init(selectedRepo: Repo, repoAPI: RepoAPI, logger: Logging?) {
        self.selectedRepo = selectedRepo
        self.repoAPI = repoAPI
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BranchListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Branch")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        logger?.log("[BranchListVC] start loading...")
        repoAPI.branches(owner: selectedRepo.owner, repo: selectedRepo.name) { [weak self, weak tableView] (response) in
            switch response.result {
            case .success(let value):
                self?.logger?.log("[BranchListVC] loaded")
                self?.list = value
                tableView?.reloadData()
            case .failure(let error):
                self?.logger?.log("[BranchListVC] error: \(error)")
            }
        }
    }
}

extension BranchListVC: UITableViewDelegate {}

extension BranchListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let branch = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Branch", for: indexPath)
        cell.textLabel?.text = "\(branch.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
}
