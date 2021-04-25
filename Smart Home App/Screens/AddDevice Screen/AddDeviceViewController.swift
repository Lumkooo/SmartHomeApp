//
//  AddDeviceViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/25/21.
//

import UIKit

final class AddDeviceViewController: UIViewController {

    // MARK: - Properties

    private let ui = AddDeviceView()
    private let presenter: IAddDevicePresenter

    // MARK: - Init

    init(presenter: IAddDevicePresenter) {
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
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
