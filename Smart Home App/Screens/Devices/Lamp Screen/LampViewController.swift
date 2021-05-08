//
//  LampViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

final class LampViewController: EditableDeviceViewController {

    // MARK: - Properties

    private let presenter: ILampPresenter
    private let ui = LampView()

    // MARK: - Init

    init(presenter: ILampPresenter) {
        self.presenter = presenter
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.ui
        self.setupVCTitle()
        self.presenter.viewDidLoad(ui: ui)

        let importAction = UIAction(title: "Import", image: UIImage(systemName: "folder")) { action in
            print("Import")
        }
        let createAction = UIAction(title: "Create", image: UIImage(systemName: "square.and.pencil")) { action in
            print("Create")
        }
        let actions = [importAction, createAction]
        self.setupNavigationBarRightButton(actions: actions)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.saveData()
    }

    private func setupVCTitle() {
        let deviceName = self.presenter.getDeviceName()
        self.title = deviceName
    }

    @objc private func editButtonTapped() {

    }
}
