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
    func changeName(_ newName: String)
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

    init(name: String,
         code: String,
         image: UIImage,
         isLoved: Bool,
         isTurnedOn: Bool) {
        self.name = name
        self.code = code
        self.image = image
        self.isLoved = isLoved
        self.isTurnedOn = isTurnedOn
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

    func changeName(_ newName: String) {
        self.name = newName
    }
}

extension SmartHomeDevice: Equatable {
    static func == (lhs: SmartHomeDevice, rhs: SmartHomeDevice) -> Bool {
        return lhs.code == rhs.code
    }
}
