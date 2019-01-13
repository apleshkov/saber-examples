//
//  ViewController.swift
//  SaberIOSLogger
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

// @saber.scope(App)
// @saber.injectOnly
class ViewController: UIViewController {
    
    // @saber.inject
    var logger: ConsoleLogger!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIApplication.shared.appContainer.injectTo(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.log("Appeared!")
    }
}
