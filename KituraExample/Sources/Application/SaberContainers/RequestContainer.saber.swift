// Generated by Saber 0.2.1

// swiftlint:disable all

import Foundation
import Kitura

internal class RequestContainer: RequestContaining {

    internal unowned let appContainer: AppContainer

    internal unowned let routerRequest: RouterRequest

    private var cached_authorizedUserProvider: AuthorizedUserProvider?

    internal init(appContainer: AppContainer, routerRequest: RouterRequest) {
        self.appContainer = appContainer
        self.routerRequest = routerRequest
    }

    internal var authorizedUserProvider: AuthorizedUserProvider {
        if let cached = self.cached_authorizedUserProvider { return cached }
        let authorizedUserProvider = self.makeAuthorizedUserProvider()
        self.cached_authorizedUserProvider = authorizedUserProvider
        return authorizedUserProvider
    }

    internal var usersAction: UsersAction {
        let usersAction = self.makeUsersAction()
        return usersAction
    }

    internal var authorizedUser: AuthorizedUser? {
        let authorizedUser = self.makeAuthorizedUser()
        return authorizedUser
    }

    private func makeAuthorizedUserProvider() -> AuthorizedUserProvider {
        return AuthorizedUserProvider(request: self.routerRequest, userStorage: self.appContainer.userStorage)
    }

    private func makeUsersAction() -> UsersAction {
        return UsersAction(user: self.authorizedUser, userStorage: self.appContainer.userStorage)
    }

    private func makeAuthorizedUser() -> AuthorizedUser? {
        let provider = self.authorizedUserProvider
        return provider.provide()
    }

}