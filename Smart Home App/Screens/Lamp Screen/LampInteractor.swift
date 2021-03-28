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
}

protocol ILampInteractorOuter: AnyObject {
    func prepareView(lamp: Lamp)
    func changeLightColorTo(_ color: UIColor)
    func changeLightLevelTo(_ level: Int)
    func goToChangeColorVC(delegate: ColorChooserDelegate)
}

final class LampInteractor {

    // MARK: - Properties

    weak var presenter: ILampInteractorOuter?
    private var lamp: Lamp

    // MARK: - Init

    init(lamp: Lamp) {
        self.lamp = lamp
    }
}

// MARK: - ILampInteractor

extension LampInteractor: ILampInteractor {
    func loadInitData() {
        self.prepareView()
    }

    func toggleLamp() {
        self.lamp.toggleDevice()
        self.prepareView()
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
}


private extension LampInteractor {
    func prepareView() {
        self.presenter?.prepareView(lamp: self.lamp)
    }
}

// MARK: - ColorChooserDelegate

extension LampInteractor: ColorChooserDelegate {
    func colorDidChangeTo(_ color: UIColor) {
        self.setLightColor(color)
    }
}
