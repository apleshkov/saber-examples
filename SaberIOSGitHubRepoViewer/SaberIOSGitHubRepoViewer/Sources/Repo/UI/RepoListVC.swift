//
//  RepoListVC.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 12/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

protocol RepoListVCDelegate: class {
    
    func repoListVC(_ repoListVC: RepoListVC, didSelectRepo repo: Repo)
}

// @saber.scope(Repo)
class RepoListVC: UIViewController {
    
    // @saber.inject
    var repoAPI: RepoAPI!
    
    // @saber.inject
    var logger: Logging?
    
    weak var delegate: RepoListVCDelegate?
    
    private var list: [Repo] = []
}

extension RepoListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Repo")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        logger?.log("[RepoListVC] start loading...")
        repoAPI.public { [weak self, weak tableView] (response) in
            switch response.result {
            case .success(let value):
                self?.logger?.log("[RepoListVC] loaded")
                self?.list = value
                tableView?.reloadData()
            case .failure(let error):
                self?.logger?.log("[RepoListVC] error: \(error)")
            }
        }
    }
}

extension RepoListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = list[indexPath.row]
        delegate?.repoListVC(self, didSelectRepo: repo)
    }
}

extension RepoListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repo", for: indexPath)
        cell.textLabel?.text = "\(repo.fullName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
}
