//
//  AirConditioner.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/22/21.
//

import Foundation

protocol IAirConditioner {
    func setTemperatureLevel(_ temperatureLevel: Int)
    func changeTemperatureUnitTo(_ temperatureUnit: TemperatureUnit)
}

final class AirConditioner: SmartHomeDevice {

    // MARK: - Constants

    private enum Constants {
        static let comfortCelsiusTemperature = 23
        static let comfortTempratureLevel = 60
    }

    // MARK: - Properties

    private(set) var temperatureUnit: TemperatureUnit
    private(set) var temperature: Int
    // Величина уровня выставленной температуры от 0 до 100
    private(set) var temperatureLevel: Int = 0 {
        didSet {
            self.temperature = self.temperatureLevelToTemprature(self.temperatureLevel)
        }
    }
    // Минимальная и максимальная темпратура в градусах Цельсия
    private(set) var minimumTemprature = 5
    private(set) var maximumTemprature = 35

    // MARK: - Init

    init(name: String, code: String) {
        self.temperatureUnit = .celsius
        self.temperature = Constants.comfortCelsiusTemperature
        self.temperatureLevel = Constants.comfortTempratureLevel
        super.init(name: name, code: code, image: AppConstants.Images.airConditioner)
    }
}

// MARK: - IAirConditioner

extension AirConditioner: IAirConditioner {
    func setTemperatureLevel(_ temperatureLevel: Int) {
        // MARK - Обработка различных единиц измерения
        self.temperatureLevel = temperatureLevel
    }

    func changeTemperatureUnitTo(_ temperatureUnit: TemperatureUnit) {
        self.temperatureUnit = temperatureUnit
    }
}

private extension AirConditioner {
    func temperatureToTempratureLevel(_ temprature: Int) -> Int {
        return ((temprature - self.minimumTemprature) / (self.maximumTemprature-self.minimumTemprature)) * 100
    }

    func temperatureLevelToTemprature(_ tempratureLevel: Int) -> Int {
        return self.minimumTemprature + (tempratureLevel*(self.maximumTemprature-self.minimumTemprature))/100
    }
}
