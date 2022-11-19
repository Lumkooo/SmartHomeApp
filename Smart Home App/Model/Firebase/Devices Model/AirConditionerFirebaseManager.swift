//
//  AirConditionerFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class AirConditionerFirebaseManager: FirebaseDatabaseInfo {

    // MARK: - Properties
    
    private let catalog = "airConditioners"
}

// MARK: - IDevicesFirebaseManager

extension AirConditionerFirebaseManager: IDevicesFirebaseManager {
    func save(_ device: SmartHomeDevice,
              completion: (() -> Void)? = nil) {
        guard let airConditioner = device as? AirConditioner else {
            return
        }
        let reference = self.devicesRef.child(catalog).child("\(airConditioner.code)")
        
        reference.setValue(["name" : airConditioner.name,
                            "code" : airConditioner.code,
                            "temperature" : airConditioner.temperature,
                            "temperatureLevel" : airConditioner.temperatureLevel,
                            "isLoved" : airConditioner.isLoved,
                            "isTurnedOn" : airConditioner.isTurnedOn])
        completion?()
    }

    func get(completion: @escaping ([SmartHomeDevice]) -> Void,
             errorCompletion: @escaping () -> Void) {
        let reference = self.devicesRef.child(catalog)
        var airConditioners: [AirConditioner] = []
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for child in snapshot.children {
                    guard let array = (child as? DataSnapshot)?.value as? Dictionary<String, Any> else {
                        errorCompletion()
                        assertionFailure("Can not load airConditioners")
                        return
                    }
                    guard let name = array["name"] as? String,
                          let code = array["code"] as? String,
                          let temperature = array["temperature"] as? Int,
                          let temperatureLevel = array["temperatureLevel"] as? Int,
                          let isLoved = array["isLoved"] as? Bool,
                          let isTurnedOn = array["isTurnedOn"] as? Bool else {
                        assertionFailure("Something went wrong")
                        return
                    }
                    let airConditioner = AirConditioner(name: name,
                                                        code: code,
                                                        temperature: temperature,
                                                        temperatureLevel: temperatureLevel,
                                                        isLoved: isLoved,
                                                        isTurnedOn: isTurnedOn)
                    airConditioners.append(airConditioner)
                }
            }
            completion(airConditioners)
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
