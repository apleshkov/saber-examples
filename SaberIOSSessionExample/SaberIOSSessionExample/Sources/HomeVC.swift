//
//  HomeVC.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 02/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import UIKit
import Alamofire

// @saber.scope(App)
// @saber.injectOnly
class HomeVC: UIViewController {

    // @saber.inject
    var makeAuthVC: (() -> AuthorizerVC)!

    // @saber.inject
    var userManager: UserManager!

    private let loggedView = LoggedView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userManagerDidUpdate),
            name: UserManager.didUpdate,
            object: nil
        )

        UIApplication.shared.appContainer.injectTo(homeVC: self)

        view.addSubview(loggedView)
        loggedView.autoCenterInSuperview()

        syncUser()
    }
}

extension HomeVC {

    private func didLoadUserName(result: Result<String>) {
        loggedView.isHidden = false
        switch result {
        case .success(let name):
            loggedView.userName = name
            loggedView.setAction(title: "Logout") { [unowned self] in
                self.logOut()
            }
        case .failure(let error):
            print(error.localizedDescription)
            loggedView.userName = "Unknown: see error logs"
            loggedView.setAction(title: "Logout") { [unowned self] in
                self.logOut()
            }
        }
    }

    private func syncUser() {
        if let userContainer = userManager.userContainer {
            loggedView.isHidden = true
            userContainer.userAPI.getName { [weak self] (response) in
                self?.didLoadUserName(result: response.result)
            }
        } else {
            loggedView.userName = "Anonymous"
            loggedView.setAction(title: "Login") { [unowned self] in
                self.logIn()
            }
        }
    }

    private func logIn() {
        let authVC = makeAuthVC()
        authVC.delegate = self
        let navVC = UINavigationController(rootViewController: authVC)
        present(navVC, animated: true) { [unowned authVC] in authVC.load() }
    }

    private func logOut() {
        userManager.logOut()
    }

    @objc private func userManagerDidUpdate() {
        syncUser()
    }
}

extension HomeVC: AuthorizerVCDelegate {

    func authorizerVCDidCancel(_ vc: AuthorizerVC) {
        vc.dismiss(animated: true, completion: nil)
    }

    func authorizerVC(_ vc: AuthorizerVC, didFinishWithToken token: String?) {
        vc.dismiss(animated: true, completion: nil)
        if let token = token {
            userManager.logIn(accessToken: token)
        }
    }
}
