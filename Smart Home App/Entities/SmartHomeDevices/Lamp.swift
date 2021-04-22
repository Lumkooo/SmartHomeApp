//
//  Lamp.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol ILamp {
    func changeLightLevelTo(_ lightLevel: Int)
    func changeLightColorTo(_ lightColor: UIColor)
}

final class Lamp: SmartHomeDevice {

    // MARK: - Constants

    private enum Constants {
        static let standardLightLevel = 50
    }


    // MARK: - Properties

    // Допустимый уровень света от 0 до 100
    private(set) var lightLevel: Int {
        willSet {
            if newValue < 0 {
                self.lightLevel = 0
            } else if newValue > 100 {
                self.lightLevel = 100
            }
        }
    }

    private(set) var lightColor: UIColor = .white

    // MARK: - Init

    init(name: String, code: String) {
        self.lightLevel = Constants.standardLightLevel
        super.init(name: name, code: code, image: AppConstants.Images.lamp)
    }

    init(name: String,
         code: String,
         lightLevel: Int,
         lightColor: UIColor,
         isLoved: Bool,
         isTurnedOn: Bool) {
        self.lightLevel = lightLevel
        self.lightColor = lightColor
        super.init(name: name,
                   code: code,
                   image: AppConstants.Images.lamp,
                   isLoved: isLoved,
                   isTurnedOn: isTurnedOn)
    }
}

// MARK: ILamp

extension Lamp: ILamp {
    func changeLightLevelTo(_ lightLevel: Int) {
        self.lightLevel = lightLevel
    }

    func changeLightColorTo(_ lightColor: UIColor) {
        self.lightColor = lightColor
    }
}
