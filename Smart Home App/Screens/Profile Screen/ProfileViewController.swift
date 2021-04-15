//
//  ProfileViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/31/21.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Properties

    private let ui = ProfileView()
    private let presenter: IProfilePresenter

    // MARK: - Init

    init(presenter: IProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.ui
        self.presenter.viewDidLoad(ui: self.ui)
    }
}
