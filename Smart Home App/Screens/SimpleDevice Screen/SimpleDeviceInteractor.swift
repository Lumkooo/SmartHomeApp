//
//  SimpleDeviceInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import Foundation

protocol ISimpleDeviceInteractor {
    func loadInitData()
    func getDeviceName() -> String
    func toggleState()
    func saveData()
}

protocol ISimpleDeviceInteractorOuter: AnyObject {
    func prepareView(device: SmartHomeDevice)
    func reloadStateOfDevice(_ device: SmartHomeDevice)
}

final class SimpleDeviceInteractor {

    // MARK: - Properties

    weak var presenter: ISimpleDeviceInteractorOuter?
    private let device: SmartHomeDevice
    private let firebaseManager = FirebaseDatabaseManager()

    // MARK: - Init

    init(device: SmartHomeDevice) {
        self.device = device
    }
}

// MARK: - ISimpleDeviceInteractor

extension SimpleDeviceInteractor: ISimpleDeviceInteractor {
    func loadInitData() {
        self.presenter?.prepareView(device: self.device)
    }

    func getDeviceName() -> String {
        return self.device.name
    }

    func toggleState() {
        self.device.toggleDevice()
        self.presenter?.reloadStateOfDevice(self.device)
    }

    func saveData() {
        self.firebaseManager.saveDevice(device)
    }
}
