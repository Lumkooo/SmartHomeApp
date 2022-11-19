//
//  LovedDevicesViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/18/21.
//

import UIKit

final class LovedDevicesViewController: UIViewController {

    // MARK: - Properties

    private let presenter: ILovedDevicesPresenter
    private let ui = MainView()

    // MARK: - Init

    init(presenter: ILovedDevicesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.title = Localized("lovedDevices")
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
        self.presenter.viewDidAppear()
    }
}

extension LovedDevicesViewController: ILovedDevicesDelegate {
    func reloadData() {
        self.presenter.reloadData()
    }
}
