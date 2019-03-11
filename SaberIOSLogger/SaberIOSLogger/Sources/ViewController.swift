//
//  ViewController.swift
//  SaberIOSLogger
//
//  Created by Andrew Pleshkov on 13/01/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

// @saber.scope(App)
class ViewController: UIViewController {
    
    private let logger: ConsoleLogger
    
    // @saber.inject
    init(logger: ConsoleLogger) {
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.log("Appeared!")
    }
}
