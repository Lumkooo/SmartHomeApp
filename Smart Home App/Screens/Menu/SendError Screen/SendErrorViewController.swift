//
//  SendErrorViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

final class SendErrorViewController: UIViewController {

    // MARK: - Properties

    private let ui = SendErrorView()
    private let presenter: ISendErrorPresenter

    // MARK: - Init

    init(presenter: ISendErrorPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.ui
        self.presenter.viewDidLoad(ui: self.ui)
    }
}
