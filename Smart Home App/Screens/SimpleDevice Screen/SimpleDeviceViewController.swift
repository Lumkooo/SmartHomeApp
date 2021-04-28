//
//  SimpleDeviceViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import UIKit

final class SimpleDeviceViewController: EditableDeviceViewController {

    // MARK: - Properties

    private let presenter: ISimpleDevicePresenter
    private let ui = SimpleDeviceView()

    // MARK: - Init

    init(presenter: ISimpleDevicePresenter) {
        self.presenter = presenter
        super.init()
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

    private func setupVCTitle() {
        let deviceName = self.presenter.getDeviceName()
        self.title = deviceName
    }

    @objc private func editButtonTapped() {
        
    }
}

