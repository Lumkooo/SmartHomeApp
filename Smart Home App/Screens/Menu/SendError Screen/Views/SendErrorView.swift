//
//  SendErrorView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

protocol ISendErrorView: AnyObject {

}

final class SendErrorView: UIView {

    // MARK: - Views

//    private lazy var

    // MARK: - Properties

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ISendErrorView

extension SendErrorView: ISendErrorView {

}

// MARK: - UISetup

private extension SendErrorView {
    func setupElements() {

    }
}
