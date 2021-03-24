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
    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice?
}

protocol IMainInteractorOuter: AnyObject {
    func prepareView(devices: [SmartHomeDevice])
    func reloadView(devices: [SmartHomeDevice])
}

final class MainInteractor {

    // MARK: - Properties

    weak var presenter: IMainInteractorOuter?
    private let devices: [SmartHomeDevice] = [Lamp(name: "Освещение", code: "94057465"),
                                      ElectricalSocket(name: "Розетка", code: "13259954"),
                                      AirConditioner(name: "Кондиционер", code: "94930534"),
                                      Curtains(name: "Шторы", code: "12340895"),
                                      Ventilator(name: "Вентилятор", code: "32146854"),
                                      GarageDoor(name: "Ворота гаража", code: "12093621"),
                                      IrrigationSystem(name: "Система полива", code: "21394031")]


}

// MARK: - IMainInteractor

extension MainInteractor: IMainInteractor {
    func loadInitData() {
        self.presenter?.prepareView(devices: devices)
    }

    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice? {
        if self.devices.count > indexPath.row {
            return self.devices[indexPath.row]
        } else {
            return nil
        }
    }

    func cellTappedAt(_ indexPath: IndexPath) {
        let index = indexPath.row
        self.toggleDeviceState(index: index)
        self.presenter?.reloadView(devices: self.devices)
    }
}

private extension MainInteractor {
    // Переключает состояние устройства (включено/выключено)
    func toggleDeviceState( index: Int) {
        if self.devices.count > index {
            self.devices[index].toggleDevice()
        }
    }
}
