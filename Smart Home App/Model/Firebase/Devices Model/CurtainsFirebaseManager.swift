//
//  CurtainsFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class CurtainsFirebaseManager: FirebaseDatabaseInfo {
    
    private let catalog = "curtains"
}

// MARK: - IDevicesFirebaseManager

extension CurtainsFirebaseManager: IDevicesFirebaseManager {
    func save(_ device: SmartHomeDevice,
              completion: (() -> Void)? = nil) {
        guard let curtains = device as? Curtains else {
            return
        }
        let reference = self.devicesRef.child(catalog).child("\(curtains.code)")
        reference.setValue(["name" : curtains.name,
                            "code" : curtains.code,
                            "level" : curtains.level,
                            "isLoved" : curtains.isLoved,
                            "isTurnedOn" : curtains.isTurnedOn])
        completion?()
    }
    
    func get(completion: @escaping ([SmartHomeDevice]) -> Void,
             errorCompletion: @escaping () -> Void) {
        let reference = self.devicesRef.child(catalog)
        var curtains: [Curtains] = []
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
                          let level = array["level"] as? Int,
                          let isLoved = array["isLoved"] as? Bool,
                          let isTurnedOn = array["isTurnedOn"] as? Bool else {
                        assertionFailure("Something went wrong")
                        return
                    }
                    let curtain = Curtains(name: name,
                                           code: code,
                                           level: level,
                                           isLoved: isLoved,
                                           isTurnedOn: isTurnedOn)
                    curtains.append(curtain)
                }
            }
            completion(curtains)
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
