//
//  MenuViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/17/21.
//

import UIKit

final class MenuViewController: UIViewController {

    // MARK: - Properties

    private let ui = MenuView()
    private let presenter: IMenuPresenter

    // MARK: - Init

    init(presenter: IMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.accessibilityIdentifier = "backButton"
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.tabBarController?.tabBar.frame.origin.x -= 500
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded()
//        }
        self.presenter.viewDidAppear()
    }
}

