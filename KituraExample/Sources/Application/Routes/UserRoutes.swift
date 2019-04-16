//
//  UserRoutes.swift
//  Application
//
//  Created by Andrew Pleshkov on 24/03/2019.
//

import Foundation
import Kitura

func initializeUserRoutes(app: Application) {
    app.router.get("/") { (request, response, next) in
        try request.container.usersAction.invoke(response: response)
    }
}
