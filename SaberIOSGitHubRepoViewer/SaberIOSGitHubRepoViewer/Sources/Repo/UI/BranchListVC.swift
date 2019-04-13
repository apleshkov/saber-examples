//
//  BranchListVC.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

protocol BranchListVCDelegate: class {
    
    func branchListVC(_ branchListVC: BranchListVC, didSelectRepo repo: Repo, branch: Branch)
}

class BranchListVC: UIViewController {
    
    private let repoAPI: RepoAPI
    
    private let logger: Logging?
    
    private let repo: Repo
    
    private var list: [Branch] = []
    
    weak var delegate: BranchListVCDelegate?
    
    init(repo: Repo, repoAPI: RepoAPI, logger: Logging?) {
        self.repo = repo
        self.repoAPI = repoAPI
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
    }
    
    // @saber.scope(Repo)
    class Factory {
        
        let make: (_ repo: Repo) -> BranchListVC
        
        // @saber.inject
        init(repoAPI: RepoAPI, logger: Logging?) {
            make = { (repo) in
                return BranchListVC(
                    repo: repo,
                    repoAPI: repoAPI,
                    logger: logger
                )
            }
        }
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
        repoAPI.branches(owner: repo.owner, repo: repo.name) { [weak self, weak tableView] (response) in
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

extension BranchListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let branch = list[indexPath.row]
        delegate?.branchListVC(self, didSelectRepo: repo, branch: branch)
    }
}

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
