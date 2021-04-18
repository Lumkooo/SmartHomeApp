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
    private let devices: [SmartHomeDevice] = [Lamp(name: "Освещение", code: "94057465"),
                                              ElectricalSocket(name: "Розетка", code: "13259954"),
                                              AirConditioner(name: "Кондиционер", code: "94930534"),
                                              Curtains(name: "Шторы", code: "12340895"),
                                              Ventilator(name: "Вентилятор", code: "32146854"),
                                              IrrigationSystem(name: "Система полива", code: "21394031")]
}

// MARK: - ILovedDevicesInteractor

extension LovedDevicesInteractor: ILovedDevicesInteractor {
    func loadInitData() {
        self.presenter?.reloadView(devices: self.getLovedDevices())
    }

    func reloadData() {
        self.presenter?.reloadView(devices: self.getLovedDevices())
    }

    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice? {
        DevicesManager.shared.getLovedDevice(atIndex: indexPath.item)
    }

    func cellTappedAt(_ indexPath: IndexPath) {
        let index = indexPath.item
        self.toggleDeviceState(index: index)
        self.presenter?.reloadView(devices: self.getLovedDevices())
    }

    func toggleIsLikedState(atIndexPath indexPath: IndexPath) {
        DevicesManager.shared.toggleLovedDeviceIsLoved(atIndex: indexPath.item)
        self.presenter?.reloadView(devices: self.getLovedDevices())
    }
}

private extension LovedDevicesInteractor {
    // Переключает состояние устройства (включено/выключено)
    func toggleDeviceState(index: Int) {
        DevicesManager.shared.toggleLovedDeviceState(atIndex: index)
    }

    func getLovedDevices() -> [SmartHomeDevice] {
        let devices = DevicesManager.shared.getLovedDevices()
        return devices
    }
}

