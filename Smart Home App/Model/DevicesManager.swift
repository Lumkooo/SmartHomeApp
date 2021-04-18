//
//  DevicesManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/18/21.
//

import Foundation

final class DevicesManager {

    // MARK: - Singletone

    static let shared = DevicesManager()

    // MARK: - Properties

    private var devices: [SmartHomeDevice]
    private var lovedDevices: [SmartHomeDevice]

    init() {
        // TODO: - Загрузка из Firebase
        let devices: [SmartHomeDevice] = [Lamp(name: "Освещение", code: "94057465"),
                                          ElectricalSocket(name: "Розетка", code: "13259954"),
                                          AirConditioner(name: "Кондиционер", code: "94930534"),
                                          Curtains(name: "Шторы", code: "12340895"),
                                          Ventilator(name: "Вентилятор", code: "32146854"),
                                          IrrigationSystem(name: "Система полива", code: "21394031")]
        self.devices = devices
        self.lovedDevices = devices.filter { $0.isLoved }
    }

    // MARK: - Public

    func toggleIsLovedForDeviceAt(index: Int) {
        if self.devices.count > index {
            let device = self.devices[index]
            device.toggleIsLoved()
            if device.isLoved {
                // Добавили в избранное
                self.lovedDevices.append(device)
            } else {
                // Удалили из избранного
                for (index, lovedDevice) in self.lovedDevices.enumerated() {
                    if device == lovedDevice {
                        self.lovedDevices.remove(at: index)
                    }
                }
            }
        }
    }

    func addDevice(device: SmartHomeDevice) {
        self.devices.append(device)
    }

    func getDevices() -> [SmartHomeDevice] {
        return self.devices
    }

    func getDevice(atIndex index: Int) -> SmartHomeDevice? {
        if self.devices.count > index {
            return self.devices[index]
        } else {
            return nil
        }
    }

    func toggleDeviceState(atIndex index: Int) {
        if self.devices.count > index {
            self.devices[index].toggleDevice()
        }
    }
}

// MARK: - Работа с избранными устройствами

extension DevicesManager {
    func getLovedDevices() -> [SmartHomeDevice] {
        return self.lovedDevices
    }

    func getLovedDevice(atIndex index: Int) -> SmartHomeDevice? {
        if self.lovedDevices.count > index {
            return self.lovedDevices[index]
        } else {
            return nil
        }
    }

    func toggleLovedDeviceState(atIndex index: Int) {
        if self.lovedDevices.count > index {
            self.lovedDevices[index].toggleDevice()
        }
    }

    func toggleLovedDeviceIsLoved(atIndex index: Int) {
        if self.lovedDevices.count > index {
            self.lovedDevices[index].toggleIsLoved()
            self.lovedDevices.remove(at: index)
        }
    }
}

// MARK: - Private

private extension DevicesManager {

}
