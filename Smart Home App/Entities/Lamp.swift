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

    init(name: String, code: String, lightLevel: Int) {
        self.lightLevel = lightLevel
        super.init(name: name, code: code, image: AppConstants.Images.lamp)
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
