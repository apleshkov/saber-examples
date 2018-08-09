//
//  LoggedView.swift
//  SaberIOSSessionExample
//
//  Created by andrey.pleshkov on 06/08/2018.
//  Copyright © 2018 saber. All rights reserved.
//

import UIKit
import PureLayout

class LoggedView: UIView {

    private let nameLabel: UILabel

    private let actionButton: UIButton

    private var actionHandler: (() -> ())?

    override init(frame: CGRect) {
        nameLabel = UILabel(frame: .zero)
        nameLabel.numberOfLines = 0

        actionButton = UIButton(type: .system)

        super.init(frame: frame)

        let stackView = UIStackView(arrangedSubviews: [nameLabel, actionButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewMargins()

        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoggedView {

    var userName: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
            setNeedsUpdateConstraints()
        }
    }

    func setAction(title: String?, handler: (() -> ())? = nil) {
        actionButton.setTitle(title, for: .normal)
        actionHandler = handler
        setNeedsUpdateConstraints()
    }

    @objc private func didTapActionButton() {
        actionHandler?()
    }
}
