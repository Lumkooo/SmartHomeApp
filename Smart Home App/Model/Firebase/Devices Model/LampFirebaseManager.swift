//
//  LampFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class LampFirebaseManager: FirebaseDatabaseInfo {

    // MARK: - Properties

    private let catalog = "lamps"
}

// MARK: - IDevicesFirebaseManager

extension LampFirebaseManager: IDevicesFirebaseManager {

    func save(_ device: SmartHomeDevice,
              completion: (() -> Void)? = nil) {
        guard let lamp = device as? Lamp else {
            return
        }
        let reference = self.devicesRef.child(self.catalog).child(lamp.code)
        reference.setValue(["name" : lamp.name,
                            "code" : lamp.code,
                            "lightColor" : lamp.lightColor.toHexString(),
                            "lightLevel" : lamp.lightLevel,
                            "isLoved" : lamp.isLoved,
                            "isTurnedOn" : lamp.isTurnedOn])
        completion?()
    }

    func get(completion: @escaping ([SmartHomeDevice]) -> Void,
             errorCompletion: @escaping () -> Void) {
        let reference = self.devicesRef.child(self.catalog)
        var lamps: [Lamp] = []
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for child in snapshot.children {
                    guard let array = (child as? DataSnapshot)?.value as? Dictionary<String, Any> else {
                        errorCompletion()
                        assertionFailure("Can not load lamps")
                        return
                    }
                    guard let name = array["name"] as? String,
                          let code = array["code"] as? String,
                          let lightColor = array["lightColor"] as? String,
                          let lightLevel = array["lightLevel"] as? Int,
                          let isLoved = array["isLoved"] as? Bool,
                          let isTurnedOn = array["isTurnedOn"] as? Bool else {
                        assertionFailure("Something went wrong")
                        return
                    }
                    let lamp = Lamp(name: name,
                                    code: code,
                                    lightLevel: lightLevel,
                                    lightColor: UIColor(hexString: lightColor),
                                    isLoved: isLoved,
                                    isTurnedOn: isTurnedOn)
                    lamps.append(lamp)
                }
            }
            completion(lamps)
        })
    }

    func removeWithCode(_ code: String,
                        completion: @escaping () -> Void,
                        errorCompletion: @escaping (_ error: Error) -> Void){
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
