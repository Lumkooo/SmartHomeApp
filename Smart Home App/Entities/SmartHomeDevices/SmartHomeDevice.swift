//
//  SmartHomeDevice.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol ISmartHomeDevice {
    func turnOn()
    func turnOff()
    func toggleDevice()
    func toggleIsLoved()
}

class SmartHomeDevice: ISmartHomeDevice {

    // MARK: - Properties

    private(set) var name: String
    private(set) var code: String
    private(set) var isTurnedOn: Bool = false
    private(set) var isLoved: Bool = false
    var image: UIImage

    // MARK: - Init

    init(name: String,
         code: String,
         image: UIImage) {
        self.name = name
        self.code = code
        self.image = image
    }

    // MARK: - ISmartHomeDevice

    func turnOn() {
        self.isTurnedOn = true
    }

    func turnOff() {
        self.isTurnedOn = false
    }

    func toggleDevice() {
        self.isTurnedOn = !self.isTurnedOn
    }

    func toggleIsLoved() {
        self.isLoved = !self.isLoved
    }
}

extension SmartHomeDevice: Equatable {
    static func == (lhs: SmartHomeDevice, rhs: SmartHomeDevice) -> Bool {
        return lhs.code == rhs.code
    }
}
