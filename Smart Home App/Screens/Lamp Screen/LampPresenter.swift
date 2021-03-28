//
//  LampPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

protocol ILampPresenter {
    func viewDidLoad(ui: ILampView)
    func viewDidAppear()
}

final class LampPresenter {

    // MARK: - Properties

    private let interactor: ILampInteractor
    private let router: ILampRouter
    private weak var ui: ILampView?

    // MARK: - Init

    init(interactor: ILampInteractor, router: ILampRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ILampPresenter

extension LampPresenter: ILampPresenter {
    func viewDidLoad(ui: ILampView) {
        self.ui = ui
        self.ui?.toggleLamp = { [weak self] in
            self?.interactor.toggleLamp()
        }
        self.ui?.sliderDidChangeValue = { [weak self] newValue in
            self?.interactor.setLightLevel(newValue)
        }
        self.ui?.colorChangeButtonPressed = { [weak self] in
            self?.interactor.colorChangeButtonPressed()
        }
    }

    func viewDidAppear() {
        self.interactor.loadInitData()
    }
}

// MARK: - ILampInteractorOuter

extension LampPresenter: ILampInteractorOuter {
    func prepareView(lamp: Lamp) {
        self.ui?.prepareView(lamp: lamp)
    }

    func changeLightColorTo(_ color: UIColor) {
        self.ui?.changeLightColorTo(color)
    }

    func changeLightLevelTo(_ level: Int) {
        self.ui?.changeLightLevelTo(level)
    }

    func goToChangeColorVC(delegate: ColorChooserDelegate) {
        self.router.showChangeColorVC(delegate: delegate)
    }
}
