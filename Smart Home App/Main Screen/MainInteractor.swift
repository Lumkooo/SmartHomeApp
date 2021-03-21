//
//  MainInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import Foundation

protocol IMainInteractor {
    func loadInitData()
}

protocol IMainInteractorOuter: AnyObject {
    func prepareView(devices: [SmartHomeDevice])
}

final class MainInteractor {
    weak var presenter: IMainInteractorOuter?

}

// MARK: - IMainInteractor

extension MainInteractor: IMainInteractor {
    func loadInitData() {
        let devices: [SmartHomeDevice] = [Lamp(name: "New Lamp", code: "94057465", lightLevel: 50),
                                          Lamp(name: "One more Lamp", code: "94057465", lightLevel: 50),
                                          Lamp(name: "Hello", code: "94057465", lightLevel: 50),
                                          Lamp(name: "Hmmm", code: "94057465", lightLevel: 50),
                                          Lamp(name: "Lier", code: "94057465", lightLevel: 50),
                                          Lamp(name: "Okay", code: "94057465", lightLevel: 50),
                                          ElectricalSocket(name: "Розетка", code: "13259954") ]
        self.presenter?.prepareView(devices: devices)
    }
}
