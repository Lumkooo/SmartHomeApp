//
//  AddDeviceInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/25/21.
//

import Foundation

protocol IAddDeviceInteractor {
    func saveDevice(name: String, code: String)
}

protocol IAddDeviceInteractorOuter: AnyObject {
    func dismissVC()
}

final class AddDeviceInteractor {

    // MARK: - Properties

    weak var presenter: IAddDeviceInteractorOuter?
    private let delegate: IAddDeviceDelegate

    // MARK: - Init

    init(delegate: IAddDeviceDelegate) {
        self.delegate = delegate
    }
}

// MARK: - IAddDeviceInteractor

extension AddDeviceInteractor: IAddDeviceInteractor {
    func saveDevice(name: String, code: String) {
        guard let device = DevicesManager.shared.createDevice(code: code, name: name) else {
            return
        }
        DevicesManager.shared.addDevice(device: device)
        self.delegate.deviceAdded()
        self.presenter?.dismissVC()
    }
}
