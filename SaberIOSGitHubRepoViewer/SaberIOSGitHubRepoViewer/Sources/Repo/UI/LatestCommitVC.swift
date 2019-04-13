//
//  LatestCommitVC.swift
//  SaberIOSGitHubRepoViewer
//
//  Created by Andrew Pleshkov on 11/04/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit
import SnapKit

class LatestCommitVC: UIViewController {
    
    private let repoAPI: RepoAPI
    
    private let logger: Logging?
    
    private let repo: Repo
    
    private let branch: Branch
    
    init(repo: Repo, branch: Branch, repoAPI: RepoAPI, logger: Logging?) {
        self.repo = repo
        self.branch = branch
        self.repoAPI = repoAPI
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
    }
    
    // @saber.scope(Repo)
    class Factory {
        
        let make: (_ repo: Repo, _ branch: Branch) -> LatestCommitVC
        
        // @saber.inject
        init(repoAPI: RepoAPI, logger: Logging?) {
            make = { (repo, branch) in
                return LatestCommitVC(
                    repo: repo,
                    branch: branch,
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

extension LatestCommitVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Latest Commit"
        view.backgroundColor = .white
        
        let shaLabel = UILabel(frame: .zero)
        shaLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        
        let authorLabel = UILabel(frame: .zero)
        authorLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        let dateLabel = UILabel(frame: .zero)
        
        let messageLabel = UILabel(frame: .zero)
        messageLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        messageLabel.numberOfLines = 0
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [shaLabel, authorLabel, dateLabel, messageLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
        }
        
        logger?.log("[LatestCommitVC] start loading...")
        repoAPI.latestCommit(owner: repo.owner, repo: repo.name, branch: branch.name) { [weak self] (response) in
            switch response.result {
            case .success(let value):
                self?.logger?.log("[LatestCommitVC] loaded")
                shaLabel.text = value.sha
                authorLabel.text = "\(value.author.name) <\(value.author.email)>"
                dateLabel.text = DateFormatter.localizedString(
                    from: value.date,
                    dateStyle: .medium,
                    timeStyle: .medium
                )
                messageLabel.text = value.message
                self?.view.setNeedsUpdateConstraints()
            case .failure(let error):
                self?.logger?.log("[LatestCommitVC] error: \(error)")
            }
        }
    }
}
