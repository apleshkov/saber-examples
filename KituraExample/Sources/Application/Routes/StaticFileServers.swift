//
//  StaticFileServers.swift
//  Application
//
//  Created by Andrey Pleshkov on 21.03.2019.
//

import Foundation
import Kitura

func initializeStaticFileServers(app: App) {
    app.router.all("/", middleware: StaticFileServer(path: "Views/public"))
}
