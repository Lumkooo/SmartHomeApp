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

    private var devices: [SmartHomeDevice] = []
    private var lovedDevices: [SmartHomeDevice] = []
    private let firebaseManager = FirebaseDatabaseManager()

    init() {
        self.firebaseManager.getDevices { (devices) in
            self.devices = devices
            self.lovedDevices = devices.filter { $0.isLoved }
        }
    }

    // MARK: - Public

    func toggleIsLovedForDeviceAt(index: Int) {
        if self.devices.count > index {
            let device = self.devices[index]
            device.toggleIsLoved()
            self.firebaseManager.saveDevice(device)
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
        self.firebaseManager.appendDevice(device)
    }

    func getDevices(completion: @escaping (([SmartHomeDevice]) -> Void)) {
        if self.devices.isEmpty {
            firebaseManager.getDevices { (devices) in
                self.devices = devices
                self.lovedDevices = self.devices.filter { $0.isLoved }
                completion(devices)
            }
        } else {
            completion(self.devices)
        }
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
            let device = devices[index]
            self.firebaseManager.saveDevice(device)
        }
    }

    func removeDevices() {
        self.devices.removeAll()
    }

    func removeLovedDevices() {
        self.lovedDevices.removeAll()
    }

    func createDevice(code: String, name: String) -> SmartHomeDevice? {
        let firstDigit = code.first

        switch firstDigit {
        case "1":
            return Lamp(name: name, code: code)
        case "2":
            return Lamp(name: name, code: code)
        case "3":
            return ElectricalSocket(name: name, code: code)
        case "4":
            return ElectricalSocket(name: name, code: code)
        case "5":
            return AirConditioner(name: name, code: code)
        case "6":
            return AirConditioner(name: name, code: code)
        case "7":
            return Curtains(name: name, code: code)
        case "8":
            return Curtains(name: name, code: code)
        case "9":
            return Ventilator(name: name, code: code)
        case "0":
            return IrrigationSystem(name: name, code: code)
        default:
            return nil
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
            let device = devices[index]
            self.firebaseManager.saveDevice(device)
        }
    }

    func toggleLovedDeviceIsLoved(atIndex index: Int) {
        if self.lovedDevices.count > index {
            self.lovedDevices[index].toggleIsLoved()
            self.lovedDevices.remove(at: index)
            let device = devices[index]
            self.firebaseManager.saveDevice(device)
        }
    }
}

// MARK: - Private

private extension DevicesManager {

}
