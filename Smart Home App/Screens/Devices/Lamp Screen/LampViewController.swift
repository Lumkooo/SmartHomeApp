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
    private var isDeleting: Bool = false

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
        self.setupNavigationBarButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isDeleting {
            self.presenter.saveData()
        }
    }

    private func setupVCTitle() {
        let deviceName = self.presenter.getDeviceName()
        self.title = deviceName
    }

    private func setupNavigationBarButton() {
        let getInfoAction = UIAction(title: Localized("getInfo") ,
                                     image: AppConstants.Images.infoCircle) { action in
            self.presenter.getInfo()
        }
        let renameAction = UIAction(title: Localized("rename"),
                                    image: AppConstants.Images.pencil ) { action in
            self.presenter.rename()
        }

        let deleteAction = UIAction(title: Localized("delete"),
                                    image: AppConstants.Images.xmark ) { action in
            self.presenter.delete()
            self.isDeleting = true
        }
        let actions = [getInfoAction, renameAction, deleteAction]
        self.setupNavigationBarRightButton(actions: actions)
    }
}
