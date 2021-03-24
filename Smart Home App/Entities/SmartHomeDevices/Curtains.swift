//
//  Curtains.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/22/21.
//

import Foundation

protocol ICurtains {
    func setLevel(_ level: Int)
}

final class Curtains: SmartHomeDevice {

    // MARK: - Constants

    private enum Constants {
        static let fullyClosedCurtains = 100
        static let halfOpenedCurtains = 50
        static let fullyOpenedCurtains = 0
    }

    // MARK: - Properties

    private(set) var level: Int

    // MARK: - Init

    init(name: String, code: String) {
        self.level = Constants.fullyOpenedCurtains
        super.init(name: name, code: code, image: AppConstants.Images.curtains)
    }

    override func turnOn() {
        super.turnOn()
        self.level = Constants.fullyClosedCurtains
    }

    override func turnOff() {
        super.turnOff()
        self.level = Constants.halfOpenedCurtains
    }
}

// MARK: - ICurtains

extension Curtains: ICurtains {
    func setLevel(_ level: Int) {
        self.level = level
    }
}