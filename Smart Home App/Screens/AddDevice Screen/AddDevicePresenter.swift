//
//  AddDevicePresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/25/21.
//

import Foundation

protocol IAddDevicePresenter {
    func viewDidLoad(ui: IAddDeviceView)
}

final class AddDevicePresenter {

    // MARK: - Properties

    private let interactor: IAddDeviceInteractor
    private let router: IAddDeviceRouter
    private weak var ui: IAddDeviceView?

    // MARK: - Init

    init(interactor: IAddDeviceInteractor, router: IAddDeviceRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IAddDevicePresenter

extension AddDevicePresenter: IAddDevicePresenter {
    func viewDidLoad(ui: IAddDeviceView) {
        self.ui = ui
        self.ui?.codeError = { [weak self] in
            self?.router.showCodeError()
        }
        self.ui?.nameError = { [weak self] in
            self?.router.showNameError()
        }
        self.ui?.save = { [weak self] (name, code) in
            self?.interactor.saveDevice(name: name, code: code)
        }
    }

    func dismissVC() {
        self.router.dismissVC()
    }
}

// MARK: - IAddDeviceInteractorOuter

extension AddDevicePresenter: IAddDeviceInteractorOuter {

}
