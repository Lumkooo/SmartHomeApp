//
//  AirConditionerViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/13/21.
//

import UIKit

final class AirConditionerViewController: UIViewController {

    // MARK: - Properties

    private let ui = AirConditionerView()
    private let presenter: IAirConditionerPresenter

    // MARK: - Init

    init(presenter: IAirConditionerPresenter) {
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
