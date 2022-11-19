//
//  LampInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

protocol ILampInteractor {
    func loadInitData()
    func toggleLamp()
    func setLightLevel(_ level: Int)
    func setLightColor(_ color: UIColor)
    func colorChangeButtonPressed()
    func getDeviceName() -> String
    func saveData()
    func sliderDidEndGesture(withValue value: Int)

    func getDevice() -> SmartHomeDevice
    func changeDeviceName(_ newName: String)
    func deleteDevice()
}

protocol ILampInteractorOuter: AnyObject {
    func prepareView(lamp: Lamp)
    func changeLightColorTo(_ color: UIColor)
    func changeLightLevelTo(_ level: Int)
    func goToChangeColorVC(delegate: ColorChooserDelegate)
    func reloadLampInfo(lamp: Lamp)
    func goToPreviousVC()
    func showAlertWith(message: String)
}

final class LampInteractor {

    // MARK: - Properties

    weak var presenter: ILampInteractorOuter?
    private var lamp: Lamp
    private let delegate: IReloadAfterRemovedDevice

    // MARK: - Init

    init(lamp: Lamp, delegate: IReloadAfterRemovedDevice) {
        self.lamp = lamp
        self.delegate = delegate
    }
}

// MARK: - ILampInteractor

extension LampInteractor: ILampInteractor {
    func loadInitData() {
        self.presenter?.prepareView(lamp: self.lamp)
    }

    func toggleLamp() {
        self.lamp.toggleDevice()
        self.presenter?.reloadLampInfo(lamp: self.lamp)
    }

    func setLightLevel(_ level: Int) {
        self.lamp.changeLightLevelTo(level)
        self.presenter?.changeLightLevelTo(level)
    }

    func setLightColor(_ color: UIColor) {
        self.lamp.changeLightColorTo(color)
        self.presenter?.changeLightColorTo(color)
    }

    func colorChangeButtonPressed() {
        self.presenter?.goToChangeColorVC(delegate: self)
    }

    func getDeviceName() -> String {
        return self.lamp.name
    }

    func saveData() {
        DevicesManager.shared.saveDevice(self.lamp)
    }

    func sliderDidEndGesture(withValue value: Int) {
        self.lamp.changeLightLevelTo(value)
        self.saveData()
    }

    func getDevice() -> SmartHomeDevice {
        return self.lamp
    }

    func changeDeviceName(_ newName: String) {
        self.lamp.changeName(newName)
        self.saveData()
    }

    func deleteDevice() {

        self.delegate.reloadAfterDelete(withDevice: self.lamp)
        self.presenter?.goToPreviousVC()
    }
}

// MARK: - ColorChooserDelegate

extension LampInteractor: ColorChooserDelegate {
    func colorDidChangeTo(_ color: UIColor) {
        self.setLightColor(color)
    }
}
