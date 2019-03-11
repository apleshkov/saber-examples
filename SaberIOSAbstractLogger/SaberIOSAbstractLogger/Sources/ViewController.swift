//
//  ViewController.swift
//  SaberIOSAbstractLogger
//
//  Created by Andrew Pleshkov on 11/03/2019.
//  Copyright © 2019 saber. All rights reserved.
//

import UIKit

// @saber.scope(App)
class ViewController: UIViewController {

    private let logger: Logger?
    
    // @saber.inject
    init(logger: Logger?) {
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger?.log("Appeared!")
    }
}
