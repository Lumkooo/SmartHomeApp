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
    func saveData()

    func getInfo()
    func rename()
    func delete()
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

    func saveData() {
        self.interactor.saveData()
    }

    func getInfo() {
        let device = self.interactor.getDevice()
        self.router.showDeviceInfo(forDevice: device)
    }

    func rename() {
        let device = self.interactor.getDevice()
        self.router.showRenameVC(forDevice: device)
    }

    func delete() {
        let device = self.interactor.getDevice()
        self.router.showDeleteAlert(forDevice: device)
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

    func goToPreviousVC() {
        self.router.dismissVC()
    }

    func showAlertWith(message: String) {
        self.router.showAlertWith(message: message)
    }
}

// MARK: - ISimpleDeviceRouterOuter

extension SimpleDevicePresenter: ISimpleDeviceRouterOuter {
    func changeDeviceName(newName: String) {
        self.interactor.changeDeviceName(newName)
    }

    func deleteDevice() {
        self.interactor.deleteDevice()
    }
}
