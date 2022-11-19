//
//  FirebaseDatabaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import Foundation
import Firebase

final class FirebaseDatabaseManager {

    // MARK: - Properties

    private let lampManager = LampFirebaseManager()
    private let electricalSocketManager = ElectricalSocketFirebaseManager()
    private let airConditionerManager = AirConditionerFirebaseManager()
    private let ventilatorManager = VentilatorFirebaseManager()
    private let irrigationSystemManager = IrrigationSystemFirebaseManager()
    private let curtainsManager = CurtainsFirebaseManager()
    private let group = DispatchGroup()
}

// MARK: - Методы для работы девайсами

extension FirebaseDatabaseManager {
    func appendDevice(_ device: SmartHomeDevice,
                      completion: (() -> Void)? = nil) {
        let manager = self.getManagerForDevice(device)
        manager?.save(device, completion: completion)
    }

    func removeDevice(_ device: SmartHomeDevice,
                      completion: @escaping () -> Void,
                      errorCompletion: @escaping (Error) -> Void) {
        let manager = self.getManagerForDevice(device)
        manager?.removeWithCode(device.code,
                                completion: completion,
                                errorCompletion: errorCompletion)
    }

    func getDevices(completion: @escaping ([SmartHomeDevice]) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }

        if userUID.isEmpty {
            completion([])
            return
        }

        var devices: [SmartHomeDevice] = []
        DispatchQueue.global().async {
            self.group.enter()
            self.lampManager.get { (lamps) in
                for lamp in lamps {
                    devices.append(lamp)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.electricalSocketManager.get { (electricalSockets) in
                for socket in electricalSockets {
                    devices.append(socket)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.airConditionerManager.get { (airConditioners) in
                for airConditioner in airConditioners {
                    devices.append(airConditioner)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.ventilatorManager.get { (ventilators) in
                for ventilator in ventilators {
                    devices.append(ventilator)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.irrigationSystemManager.get { (irrigationSystems) in
                for irrigationSystem in irrigationSystems {
                    devices.append(irrigationSystem)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.curtainsManager.get { (curtains) in
                for curtain in curtains {
                    devices.append(curtain)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.notify(queue: .main) {
                completion(devices)
            }
        }
    }

    func saveDevices(_ devices: [SmartHomeDevice]) {
        for device in devices {
            let manager = self.getManagerForDevice(device)
            manager?.save(device, completion: nil)
        }
    }

    func saveDevice(_ device: SmartHomeDevice) {
        let manager = self.getManagerForDevice(device)
        manager?.save(device, completion: nil)
    }
}

// MARK: - Private

private extension FirebaseDatabaseManager {
    func getManagerForDevice(_ device: SmartHomeDevice) -> IDevicesFirebaseManager? {
        if device is Lamp {
            return self.lampManager
        } else if device is ElectricalSocket {
            return self.electricalSocketManager
        } else if device is AirConditioner {
            return self.airConditionerManager
        } else if device is Curtains {
            return self.curtainsManager
        } else if device is Ventilator {
            return self.ventilatorManager
        } else if device is IrrigationSystem {
            return self.irrigationSystemManager
        } else {
            return nil
        }
    }
}
