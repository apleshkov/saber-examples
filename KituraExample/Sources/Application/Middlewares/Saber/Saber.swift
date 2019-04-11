//
//  Saber.swift
//  Application
//
//  Created by Andrey Pleshkov on 20.03.2019.
//

import Foundation
import Kitura

class Saber: RouterMiddleware {
    
    private unowned let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        request.container = RequestContainer(
            appContainer: appContainer,
            routerRequest: request
        )
        next()
    }
}
