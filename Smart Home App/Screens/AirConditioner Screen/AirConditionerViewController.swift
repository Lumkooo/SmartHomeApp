//
//  AirConditionerViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/13/21.
//

import UIKit

final class AirConditionerViewController: EditableDeviceViewController {

    // MARK: - Properties

    private let ui = AirConditionerView()
    private let presenter: IAirConditionerPresenter

    // MARK: - Init

    init(presenter: IAirConditionerPresenter) {
        self.presenter = presenter
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.ui
        self.presenter.viewDidLoad(ui: self.ui)
        let importAction = UIAction(title: "Import", image: UIImage(systemName: "folder")) { action in
            print("Import")
        }
        let createAction = UIAction(title: "Create", image: UIImage(systemName: "square.and.pencil")) { action in
            print("Create")
        }
        let actions = [importAction, createAction]
        self.setupNavigationBarRightButton(actions: actions)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.saveData()
    }

    // MARK: - Private

    @objc private func editButtonTapped() {
        
    }
}
