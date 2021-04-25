//
//  LovedDevicesInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/18/21.
//

import Foundation

protocol ILovedDevicesInteractor {
    func loadInitData()
    func reloadData()
    func cellTappedAt(_ indexPath: IndexPath)
    func toggleIsLikedState(atIndexPath indexPath: IndexPath)
    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice?
}

protocol ILovedDevicesInteractorOuter: AnyObject {
    func reloadView(devices: [SmartHomeDevice])
}

final class LovedDevicesInteractor {

    // MARK: - Properties

    weak var presenter: ILovedDevicesInteractorOuter?
}

// MARK: - ILovedDevicesInteractor

extension LovedDevicesInteractor: ILovedDevicesInteractor {
    func loadInitData() {
        self.reloadView()
    }

    func reloadData() {
        self.reloadView()
    }

    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice? {
        DevicesManager.shared.getLovedDevice(atIndex: indexPath.item)
    }

    func cellTappedAt(_ indexPath: IndexPath) {
        let index = indexPath.item
        self.toggleDeviceState(index: index)
        self.reloadView()
    }

    func toggleIsLikedState(atIndexPath indexPath: IndexPath) {
        DevicesManager.shared.toggleLovedDeviceIsLoved(atIndex: indexPath.item)
        self.reloadView()
    }
}

private extension LovedDevicesInteractor {
    // Переключает состояние устройства (включено/выключено)
    func toggleDeviceState(index: Int) {
        DevicesManager.shared.toggleLovedDeviceState(atIndex: index)
    }

    func getLovedDevices() -> [SmartHomeDevice] {
        return DevicesManager.shared.getLovedDevices()
    }

    func reloadView() {
        let lovedDevices = self.getLovedDevices()
        self.presenter?.reloadView(devices: lovedDevices)
    }
}

