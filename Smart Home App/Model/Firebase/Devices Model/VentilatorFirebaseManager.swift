//
//  VentilatorFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class VentilatorFirebaseManager: FirebaseDatabaseInfo {

    // MARK: - Properties
    
    private let catalog = "ventilators"
}

// MARK: - IDeviceFirebaeManager
extension VentilatorFirebaseManager: IDevicesFirebaseManager {
    func save(_ device: SmartHomeDevice,
              completion: (() -> Void)? = nil) {
        guard let ventilator = device as? Ventilator else {
            return
        }
        let reference = self.devicesRef.child(catalog).child("\(ventilator.code)")
        reference.setValue(["name" : ventilator.name,
                            "code" : ventilator.code,
                            "isLoved" : ventilator.isLoved,
                            "isTurnedOn" : ventilator.isTurnedOn])
        completion?()
    }

    func get(completion: @escaping ([SmartHomeDevice]) -> Void,
             errorCompletion: @escaping () -> Void) {
        let reference = self.devicesRef.child(catalog)
        var ventilators: [Ventilator] = []
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for child in snapshot.children {
                    guard let array = (child as? DataSnapshot)?.value as? Dictionary<String, Any> else {
                        errorCompletion()
                        assertionFailure("Can not load ventilator")
                        return
                    }
                    guard let name = array["name"] as? String,
                          let code = array["code"] as? String,
                          let isLoved = array["isLoved"] as? Bool,
                          let isTurnedOn = array["isTurnedOn"] as? Bool else {
                        assertionFailure("Something went wrong")
                        return
                    }
                    let ventilator = Ventilator(name: name,
                                                code: code,
                                                isLoved: isLoved,
                                                isTurnedOn: isTurnedOn)
                    ventilators.append(ventilator)
                }
            }
            completion(ventilators)
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
