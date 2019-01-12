// Generated by Saber 0.2.0

// swiftlint:disable all

import Foundation
import KeychainAccess

internal class AppContainer: AppContaining {

    private let lock = NSRecursiveLock()

    internal let gitHub: GitHub

    internal let keychain: Keychain

    private var cached_userManager: UserManager?

    internal init(gitHub: GitHub, keychain: Keychain) {
        self.gitHub = gitHub
        self.keychain = keychain
    }

    internal var authorizerVC: AuthorizerVC {
        let authorizerVC = self.makeAuthorizerVC()
        return authorizerVC
    }

    internal var userManager: UserManager {
        self.lock.lock()
        defer { self.lock.unlock() }
        if let cached = self.cached_userManager { return cached }
        let userManager = self.makeUserManager()
        self.cached_userManager = userManager
        return userManager
    }

    private func makeAuthorizerVC() -> AuthorizerVC {
        return AuthorizerVC(github: self.gitHub)
    }

    private func makeUserManager() -> UserManager {
        return UserManager(appContainer: self, keychain: self.keychain)
    }

    internal func injectTo(homeVC: HomeVC) {
        homeVC.makeAuthVC = { [unowned self] in return self.authorizerVC }
        homeVC.userManager = self.userManager
    }

}