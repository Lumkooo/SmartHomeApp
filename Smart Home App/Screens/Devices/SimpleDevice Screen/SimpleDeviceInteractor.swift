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
    func getDevice() -> SmartHomeDevice
    func changeDeviceName(_ newName: String)
    func deleteDevice()
}

protocol ISimpleDeviceInteractorOuter: AnyObject {
    func prepareView(device: SmartHomeDevice)
    func reloadStateOfDevice(_ device: SmartHomeDevice)
    func goToPreviousVC()
    func showAlertWith(message: String)
}

final class SimpleDeviceInteractor {

    // MARK: - Properties

    weak var presenter: ISimpleDeviceInteractorOuter?
    private let device: SmartHomeDevice
    private let firebaseManager = FirebaseDatabaseManager()
    private let delegate: IReloadAfterRemovedDevice

    // MARK: - Init

    init(device: SmartHomeDevice, delegate: IReloadAfterRemovedDevice) {
        self.device = device
        self.delegate = delegate
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
        self.firebaseManager.saveDevice(self.device)
    }

    func getDevice() -> SmartHomeDevice {
        return self.device
    }

    func changeDeviceName(_ newName: String) {
        self.device.changeName(newName)
        self.saveData()
    }

    func deleteDevice() {
        
        self.delegate.reloadAfterDelete(withDevice: self.device)
        self.presenter?.goToPreviousVC()
    }
}
