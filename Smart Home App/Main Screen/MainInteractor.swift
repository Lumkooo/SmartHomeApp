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
        let devices: [SmartHomeDevice] = [Lamp(name: "Освещение", code: "94057465"),
                                          ElectricalSocket(name: "Розетка", code: "13259954"),
                                          AirConditioner(name: "Кондиционер", code: "94930534"),
                                          Curtains(name: "Шторы", code: "12340895"),
                                          Ventilator(name: "Вентилятор", code: "32146854"),
                                          GarageDoor(name: "Ворота гаража", code: "12093621"),
                                          IrrigationSystem(name: "Система полива", code: "21394031")]
        self.presenter?.prepareView(devices: devices)
    }
}
