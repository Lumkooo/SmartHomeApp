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
    private var isDeleting: Bool = false

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
        self.setupNavigationBarButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isDeleting {
            self.presenter.saveData()
        }
    }

    // MARK: - Private

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
