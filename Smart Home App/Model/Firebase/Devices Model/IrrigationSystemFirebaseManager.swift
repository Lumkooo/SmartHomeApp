//
//  IrrigationSystemFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class IrrigationSystemFirebaseManager: FirebaseDatabaseInfo {

    // MARK: - Properties

    private let catalog = "irrigationSystems"
}

// MARK: - IDeviceFirebaseManager

extension IrrigationSystemFirebaseManager: IDevicesFirebaseManager {
    func save(_ device: SmartHomeDevice,
              completion: (() -> Void)? = nil) {
        guard let irrigationSystem = device as? IrrigationSystem else {
            return
        }
        let reference = self.devicesRef.child(catalog).child("\(irrigationSystem.code)")
        reference.setValue(["name" : irrigationSystem.name,
                            "code" : irrigationSystem.code,
                            "isLoved" : irrigationSystem.isLoved,
                            "isTurnedOn" : irrigationSystem.isTurnedOn])
        completion?()
    }

    func get(completion: @escaping ([SmartHomeDevice]) -> Void,
                              errorCompletion: @escaping () -> Void) {
        let reference = self.devicesRef.child(catalog)
        var irrigationSystems: [IrrigationSystem] = []
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for child in snapshot.children {
                    guard let array = (child as? DataSnapshot)?.value as? Dictionary<String, Any> else {
                        errorCompletion()
                        assertionFailure("Can not load irrigationSystems")
                        return
                    }
                    guard let name = array["name"] as? String,
                          let code = array["code"] as? String,
                          let isLoved = array["isLoved"] as? Bool,
                          let isTurnedOn = array["isTurnedOn"] as? Bool else {
                        assertionFailure("Something went wrong")
                        return
                    }
                    let irrigationSystem = IrrigationSystem(name: name,
                                                            code: code,
                                                            isLoved: isLoved,
                                                            isTurnedOn: isTurnedOn)
                    irrigationSystems.append(irrigationSystem)
                }
            }
            completion(irrigationSystems)
        })
    }

    func removeWithCode(_ code: String,
                        completion: @escaping () -> Void,
                        errorCompletion: @escaping (Error) -> Void) {
        let reference = self.devicesRef.child(self.catalog)
        let deletingReference = reference.child(code)
        deletingReference.removeValue { (error, ref) in
            if let error = error {
                errorCompletion(error)
                return
            } else if error == nil{
                completion()
            }
        }
    }
}
