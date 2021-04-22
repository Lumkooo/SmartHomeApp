//
//  IrrigationSystemFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class IrrigationSystemFirebaseManager: FirebaseDatabaseInfo {

    private let catalog = "irrigationSystems"

    func saveIrrigationSystem(_ irrigationSystem: IrrigationSystem,
                              completion: @escaping () -> Void) {
        let reference = self.devicesRef.child(catalog).child("\(irrigationSystem.code)")
        reference.setValue(["name" : irrigationSystem.name,
                            "code" : irrigationSystem.code,
                            "isLoved" : irrigationSystem.isLoved,
                            "isTurnedOn" : irrigationSystem.isTurnedOn])
        completion()
    }

    func getIrrigationSystems(completion: @escaping ([IrrigationSystem]) -> Void,
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
}
