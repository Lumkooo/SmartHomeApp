//
//  AirConditionerInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/13/21.
//

import Foundation

protocol IAirConditionerInteractor {
    func loadInitData()
    func toggleAirConditioner()
    func setTemprature(_ newValue: Int)
}

protocol IAirConditionerInteractorOuter: AnyObject {
    func prepareView(airCoditioner: AirConditioner)
    func changeTempratureTo(_ tempratureLevel: Int)
    func reloadAirConditionerInfo(airConditioner: AirConditioner)
}

final class AirConditionerInteractor {

    // MARK: - Properties

    private let airConditioner: AirConditioner
    weak var presenter: IAirConditionerInteractorOuter?

    // MARK: - Init

    init(airConditioner: AirConditioner) {
        self.airConditioner = airConditioner
    }
}

// MARK: - IAirConditionerInteractor

extension AirConditionerInteractor: IAirConditionerInteractor {
    func loadInitData() {
        self.prepareView()
    }

    func toggleAirConditioner() {
        self.airConditioner.toggleDevice()
        self.presenter?.reloadAirConditionerInfo(airConditioner: self.airConditioner)
    }

    func setTemprature(_ newValue: Int) {
        self.airConditioner.setTemperatureLevel(newValue)
        self.presenter?.changeTempratureTo(newValue)
    }
}

private extension AirConditionerInteractor {
    func prepareView() {
        self.presenter?.prepareView(airCoditioner: self.airConditioner)
    }
}
