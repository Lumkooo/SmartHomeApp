//
//  SimpleDeviceViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import UIKit

final class SimpleDeviceViewController: UIViewController {

    // MARK: - Properties

    private let presenter: ISimpleDevicePresenter
    private let ui = SimpleDeviceView()

    // MARK: - Init

    init(presenter: ISimpleDevicePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.view = self.ui
        self.setupVCTitle()
        self.presenter.viewDidLoad(ui: self.ui)
    }

    private func setupVCTitle() {
        let deviceName = self.presenter.getDeviceName()
        self.title = deviceName
    }
}

