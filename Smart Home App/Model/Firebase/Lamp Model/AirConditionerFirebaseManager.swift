//
//  AirConditionerFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class AirConditionerFirebaseManager: FirebaseDatabaseInfo {

    private let catalog = "airConditioners"

    func saveAirConditioner(_ airConditioner: AirConditioner,
                            completion: @escaping () -> Void) {
        let reference = self.devicesRef.child(catalog).child("\(airConditioner.code)")
        
        reference.setValue(["name" : airConditioner.name,
                            "code" : airConditioner.code,
                            "temperature" : airConditioner.temperature,
                            "temperatureLevel" : airConditioner.temperatureLevel,
                            "isLoved" : airConditioner.isLoved,
                            "isTurnedOn" : airConditioner.isTurnedOn])
        completion()
    }

    func getAirConditioners(completion: @escaping ([AirConditioner]) -> Void,
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
}
