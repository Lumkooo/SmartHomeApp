//
//  FirebaseDatabaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import Foundation
import Firebase

final class FirebaseDatabaseManager: FirebaseDatabaseInfo {

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
    func appendDeviceWithCode(_ code: String,
                              completion: @escaping () -> Void,
                              errorCompletion: @escaping () -> Void) {

    }

    func deleteDevice(_ device: SmartHomeDevice,
                      completion: @escaping () -> Void,
                      errorCompletion: @escaping () -> Void) {

    }

    func getDevices(completion: @escaping ([SmartHomeDevice]) -> Void,
                    errorCompletion: @escaping () -> Void) {
        var devices: [SmartHomeDevice] = []
        DispatchQueue.global().async {

            self.group.enter()
            self.lampManager.getLamps { (lamps) in
                for lamp in lamps {
                    devices.append(lamp)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.electricalSocketManager.getElectricalSockets { (electricalSockets) in
                for socket in electricalSockets {
                    devices.append(socket)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.airConditionerManager.getAirConditioners { (airConditioners) in
                for airConditioner in airConditioners {
                    devices.append(airConditioner)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.ventilatorManager.getVentilators { (ventilators) in
                for ventilator in ventilators {
                    devices.append(ventilator)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.irrigationSystemManager.getIrrigationSystems { (irrigationSystems) in
                for irrigationSystem in irrigationSystems {
                    devices.append(irrigationSystem)
                }
                self.group.leave()
            } errorCompletion: {
                assertionFailure("oops, error!")
            }

            self.group.enter()
            self.curtainsManager.getCurtains { (curtains) in
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
}

// MARK: - Сохранение

extension FirebaseDatabaseManager {
    func saveLamp(_ lamp: Lamp,
                  completion: @escaping () -> Void) {
        self.lampManager.saveLamp(lamp, completion: completion)
    }
    
    func saveAirConditioner(_ airConditioner: AirConditioner,
                            completion: @escaping () -> Void) {
        self.airConditionerManager.saveAirConditioner(airConditioner, completion: completion)
    }
    
    func saveElectricalSocket(_ electricalSocket: ElectricalSocket,
                              completion: @escaping () -> Void) {
        self.electricalSocketManager.saveElectricalSocket(electricalSocket, completion: completion)
    }

    func saveVentilator(_ ventilator: Ventilator,
                        completion: @escaping () -> Void) {
        self.ventilatorManager.saveVentilator(ventilator, completion: completion)
    }

    func saveIrrigationSystemManager(_ irrigationSystem: IrrigationSystem,
                                     completion: @escaping () -> Void) {
        self.irrigationSystemManager.saveIrrigationSystem(irrigationSystem, completion: completion)
    }

    func saveCurtains(_ curtains: Curtains,
                      completion: @escaping () -> Void) {
        self.curtainsManager.saveCurtains(curtains, completion: completion)
    }
}
