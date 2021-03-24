//
//  LampInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import Foundation

protocol ILampInteractor {
    func loadInitData()
    func toggleLamp()
    func setLightLevel(level: Int)
}

protocol ILampInteractorOuter: AnyObject {
    func prepareView(lamp: Lamp)
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

    func setLightLevel(level: Int) {
        self.lamp.changeLightLevelTo(level)
        self.prepareView()
    }
}


private extension LampInteractor {
    func prepareView() {
        self.presenter?.prepareView(lamp: self.lamp)
    }
}
