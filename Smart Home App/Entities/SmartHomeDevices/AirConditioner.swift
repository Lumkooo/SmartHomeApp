//
//  AirConditioner.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/22/21.
//

import Foundation

protocol IAirConditioner {
    func setTemperature(_ temperature: Int)
    func changeTemperatureUnitTo(_ temperatureUnit: TemperatureUnit)
}

final class AirConditioner: SmartHomeDevice {

    // MARK: - Constants

    private enum Constants {
        static let comfortCelsiusTemperature = 23
    }

    // MARK: - Properties

    private(set) var temperatureUnit: TemperatureUnit
    private(set) var temperature: Int

    // MARK: - Init

    init(name: String, code: String) {
        self.temperatureUnit = .celsius
        self.temperature = Constants.comfortCelsiusTemperature
        super.init(name: name, code: code, image: AppConstants.Images.airConditioner)
    }
}

// MARK: - IAirConditioner

extension AirConditioner: IAirConditioner {
    func setTemperature(_ temperature: Int) {
        // MARK - Обработка различных единиц измерения
        self.temperature = temperature
    }

    func changeTemperatureUnitTo(_ temperatureUnit: TemperatureUnit) {
        self.temperatureUnit = temperatureUnit
    }
}
