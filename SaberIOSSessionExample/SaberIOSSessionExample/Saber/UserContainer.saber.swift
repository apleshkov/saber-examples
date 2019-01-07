// Generated by Saber 0.1.3

// swiftlint:disable all

import Foundation

internal class UserContainer: UserContaining {

    private let lock = NSRecursiveLock()

    internal unowned let appContainer: AppContainer

    internal let userExternals: UserExternals

    private var cached_userSessionManagerProvider: UserSessionManagerProvider?

    private var cached_userAPI: UserAPI?

    internal init(appContainer: AppContainer, userExternals: UserExternals) {
        self.appContainer = appContainer
        self.userExternals = userExternals
    }

    internal var userSessionManagerProvider: UserSessionManagerProvider {
        self.lock.lock()
        defer { self.lock.unlock() }
        if let cached = self.cached_userSessionManagerProvider { return cached }
        let userSessionManagerProvider = self.makeUserSessionManagerProvider()
        self.cached_userSessionManagerProvider = userSessionManagerProvider
        return userSessionManagerProvider
    }

    internal var userAPI: UserAPI {
        self.lock.lock()
        defer { self.lock.unlock() }
        if let cached = self.cached_userAPI { return cached }
        let userAPI = self.makeUserAPI()
        self.cached_userAPI = userAPI
        return userAPI
    }

    internal var userSessionManager: UserSessionManager {
        let userSessionManager = self.makeUserSessionManager()
        return userSessionManager
    }

    private func makeUserSessionManagerProvider() -> UserSessionManagerProvider {
        return UserSessionManagerProvider(github: self.appContainer.appExternals.github, accessToken: self.userExternals.accessToken)
    }

    private func makeUserAPI() -> UserAPI {
        return UserAPI(github: self.appContainer.appExternals.github, sessionManager: self.userSessionManager)
    }

    private func makeUserSessionManager() -> UserSessionManager {
        let provider = self.userSessionManagerProvider
        return provider.provide()
    }

}