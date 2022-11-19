//
//  LampInteractor_Test.swift
//  Smart Home AppTests
//
//  Created by Андрей Шамин on 5/22/21.
//

import Foundation
import UIKit

@testable import Smart_Home_App

class LampInteractor_Test: ILampInteractor {

    private(set) var isInitDataLoaded: Bool = false
    private(set) var isLampToggled: Bool = false
    private(set) var isLightLevelSet: Bool = false
    private(set) var lightLevel: Int = 0
    private(set) var isLightColorSet: Bool = false
    private(set) var lightColor: UIColor = .clear
    private(set) var isColorChangeButtonPressed: Bool = false
    private(set) var isDeviceNameGet: Bool = false
    private(set) var isDataSaved: Bool = false
    private(set) var isSliderEndGesture: Bool = false
    private(set) var sliderValue: Int = 0
    private(set) var device = SmartHomeDevice(name: "Name", code: "111111111", image: UIImage())
    private(set) var isDeviceNameChanged: Bool = false
    private(set) var isDeviceDeleted: Bool = false

    func loadInitData() {
        self.isInitDataLoaded = true
    }

    func toggleLamp() {
        self.isLampToggled = true
    }

    func setLightLevel(_ level: Int) {
        self.lightLevel = level
        self.isLightLevelSet = true
    }

    func setLightColor(_ color: UIColor) {
        self.lightColor = color
        self.isLightColorSet = true
    }

    func colorChangeButtonPressed() {
        self.isColorChangeButtonPressed = true
    }

    func getDeviceName() -> String {
        self.isDeviceNameGet = true
        return self.device.name
    }

    func saveData() {
        self.isDataSaved = true
    }

    func sliderDidEndGesture(withValue value: Int) {
        self.sliderValue = value
        self.isSliderEndGesture = true
    }

    func getDevice() -> SmartHomeDevice {
        return self.device
    }

    func changeDeviceName(_ newName: String) {
        self.device.changeName(newName)
        self.isDeviceNameChanged = true
    }

    func deleteDevice() {
        self.isDeviceDeleted = true
    }
}
