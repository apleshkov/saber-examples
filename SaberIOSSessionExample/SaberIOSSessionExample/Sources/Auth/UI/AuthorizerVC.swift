//
//  AuthorizerVC.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 06/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

protocol AuthorizerVCDelegate: class {

    func authorizerVC(_ vc: AuthorizerVC, didFinishWithToken token: String?)

    func authorizerVCDidCancel(_ vc: AuthorizerVC)
}

// @saber.scope(App)
class AuthorizerVC: UIViewController {

    weak var delegate: AuthorizerVCDelegate?

    private let github: GitHub

    private let webView = WKWebView(frame: .zero)

    private let authState = UUID().uuidString

    // @saber.inject
    init(github: GitHub) {
        self.github = github

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthorizerVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancel)
        )

        webView.navigationDelegate = self

        webView.frame = view.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(webView)
    }
}

extension AuthorizerVC {

    func load() {
        let path = "https://github.com/login/oauth/authorize"
        guard var comps = URLComponents(string: path) else {
            fatalError()
        }
        comps.queryItems = [
            URLQueryItem(name: "client_id", value: github.clientId),
            URLQueryItem(name: "state", value: authState),
            URLQueryItem(name: "redirect_uri", value: redirectPath)
        ]
        guard let url = comps.url else {
            fatalError()
        }
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        webView.load(request)
    }

    @objc private func didTapCancel() {
        delegate?.authorizerVCDidCancel(self)
    }
}

extension AuthorizerVC: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
            url.scheme == "test",
            url.absoluteString.hasPrefix(redirectPath),
            let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
            let state = queryItems.first(where: { $0.name == "state" })?.value,
            state == self.authState,
            let code = queryItems.first(where: { $0.name == "code" })?.value,
            code.count > 0 else {
                decisionHandler(.allow)
                return
        }
        decisionHandler(.cancel)
        loadToken(code: code)
    }
}

extension AuthorizerVC {

    private func loadToken(code: String) {
        let params: [String : String] = [
            "client_id": github.clientId,
            "client_secret": github.clientSecret,
            "code": code,
            "state": authState
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let path = "https://github.com/login/oauth/access_token"
        let request = Alamofire.request(path, method: .post, parameters: params, headers: headers)
        request.responseJSON(queue: DispatchQueue.main) { [weak self] (response) in
            guard
                let json = response.result.value as? [String : Any],
                let accessToken = json["access_token"] as? String else {
                    self?.didLoadToken(nil)
                    return
            }
            self?.didLoadToken(accessToken)
        }
    }

    private func didLoadToken(_ token: String?) {
        delegate?.authorizerVC(self, didFinishWithToken: token)
    }
}

private let redirectPath = "test://github"
