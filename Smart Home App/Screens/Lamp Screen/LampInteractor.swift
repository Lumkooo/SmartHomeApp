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
}

protocol ILampInteractorOuter: AnyObject {
    func prepareView(lamp: Lamp)
    func changeLightColorTo(_ color: UIColor)
    func changeLightLevelTo(_ level: Int)
    func goToChangeColorVC(delegate: ColorChooserDelegate)
    func reloadLampInfo(lamp: Lamp)
}

final class LampInteractor {

    // MARK: - Properties

    weak var presenter: ILampInteractorOuter?
    private var lamp: Lamp
    private let firebaseManager = FirebaseDatabaseManager()

    // MARK: - Init

    init(lamp: Lamp) {
        self.lamp = lamp
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
        self.firebaseManager.saveDevice(self.lamp)
    }

    func sliderDidEndGesture(withValue value: Int) {
        self.lamp.changeLightLevelTo(value)
        self.saveData()
    }
}

// MARK: - ColorChooserDelegate

extension LampInteractor: ColorChooserDelegate {
    func colorDidChangeTo(_ color: UIColor) {
        self.setLightColor(color)
    }
}
