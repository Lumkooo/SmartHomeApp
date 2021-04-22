//
//  VentilatorFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

final class VentilatorFirebaseManager: FirebaseDatabaseInfo {

    private let catalog = "ventilators"

    func saveVentilator(_ ventilator: Ventilator,
                        completion: @escaping () -> Void) {
        let reference = self.devicesRef.child(catalog).child("\(ventilator.code)")
        reference.setValue(["name" : ventilator.name,
                            "code" : ventilator.code,
                            "isLoved" : ventilator.isLoved,
                            "isTurnedOn" : ventilator.isTurnedOn])
        completion()
    }

    func getVentilators(completion: @escaping ([Ventilator]) -> Void,
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
}
