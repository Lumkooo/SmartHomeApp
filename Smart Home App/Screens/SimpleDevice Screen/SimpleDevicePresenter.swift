//
//  SimpleDevicePresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import Foundation

protocol ISimpleDevicePresenter {
    func getDeviceName() -> String
    func viewDidLoad(ui: ISimpleDeviceView)
}

final class SimpleDevicePresenter {

    // MARK: - Properties

    private let interactor: ISimpleDeviceInteractor
    private let router: ISimpleDeviceRouter
    private weak var ui: ISimpleDeviceView?

    // MARK: - Init

    init(interactor: ISimpleDeviceInteractor, router: ISimpleDeviceRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ISimpleDevicePresenter

extension SimpleDevicePresenter: ISimpleDevicePresenter {
    func viewDidLoad(ui: ISimpleDeviceView) {
        self.ui = ui
        self.ui?.toggleButtonTapped = { [weak self] in
            self?.interactor.toggleState()
        }
        self.interactor.loadInitData()
    }

    func getDeviceName() -> String {
        return self.interactor.getDeviceName()
    }
}

// MARK: - ISimpleDeviceInteractorOuter

extension SimpleDevicePresenter: ISimpleDeviceInteractorOuter {
    func prepareView(device: SmartHomeDevice) {
        self.ui?.prepareView(device: device)
    }

    func reloadStateOfDevice(_ device: SmartHomeDevice) {
        self.ui?.reloadStateOfDevice(device)
    }
}

