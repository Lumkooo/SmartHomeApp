//
//  MainInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import Foundation

protocol IMainInteractor {
    func loadInitData()
    func cellTappedAt(_ indexPath: IndexPath)
    func toggleIsLikedState(atIndexPath indexPath: IndexPath)
    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice?
    func userSignIn()
    func userSignOut()
    func addDeviceTapped()
    func reloadAfterDeleting(device: SmartHomeDevice)
}

protocol IMainInteractorOuter: AnyObject {
    func reloadView(devices: [SmartHomeDevice])
    func goToAddingDevice(delegate: IAddDeviceDelegate)
}

final class MainInteractor {

    // MARK: - Properties

    weak var presenter: IMainInteractorOuter?
    private let lovedDevicesDelegate: ILovedDevicesDelegate

    init(lovedDevicesDelegate: ILovedDevicesDelegate) {
        self.lovedDevicesDelegate = lovedDevicesDelegate
    }
}

// MARK: - IMainInteractor

extension MainInteractor: IMainInteractor {

    func loadInitData() {
        self.reloadView()
    }

    func reloadAfterDeleting(device: SmartHomeDevice) {
        DevicesManager.shared.removeDevice(device)
    }

    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice? {
        DevicesManager.shared.getDevice(atIndex: indexPath.item)
    }

    func cellTappedAt(_ indexPath: IndexPath) {
        let index = indexPath.row
        self.toggleDeviceState(index: index)
        self.reloadView()
    }
    
    func toggleIsLikedState(atIndexPath indexPath: IndexPath) {
        DevicesManager.shared.toggleIsLovedForDeviceAt(index: indexPath.item)
        self.updateLovedDevicesScreen()
    }

    func userSignIn() {
        self.getDevices(completion: { (devices) in
            self.presenter?.reloadView(devices: devices)
            self.lovedDevicesDelegate.reloadData()
        })
    }

    func userSignOut() {
        DevicesManager.shared.removeDevices()
        DevicesManager.shared.removeLovedDevices()
        self.getDevices(completion: { (devices) in
            self.presenter?.reloadView(devices: devices)
            self.lovedDevicesDelegate.reloadData()
        })
    }

    func addDeviceTapped() {
        self.presenter?.goToAddingDevice(delegate: self)
    }
}

private extension MainInteractor {
    // Переключает состояние устройства (включено/выключено)
    func toggleDeviceState(index: Int) {
        DevicesManager.shared.toggleDeviceState(atIndex: index)
        self.lovedDevicesDelegate.reloadData()
    }

    func getDevices(completion: @escaping (([SmartHomeDevice]) -> Void)) {
        DevicesManager.shared.getDevices { (devices) in
            completion(devices)
        }
    }

    func reloadView() {
        self.getDevices { (devices) in
            self.presenter?.reloadView(devices: devices)
        }
    }

    func updateLovedDevicesScreen() {
        self.lovedDevicesDelegate.reloadData()
    }
}

// MARK: - IAddDeviceDelegate

extension MainInteractor: IAddDeviceDelegate {
    func deviceAdded() {
        self.reloadView()
    }
}
