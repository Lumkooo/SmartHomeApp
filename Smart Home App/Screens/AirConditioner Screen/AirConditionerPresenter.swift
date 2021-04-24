//
//  AirConditionerPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/13/21.
//

import Foundation

protocol IAirConditionerPresenter {
    func viewDidLoad(ui: IAirConditionerView)
    func saveData()
}

final class AirConditionerPresenter {

    // MARK: - Properties

    private let interactor: IAirConditionerInteractor
    private let router: IAirConditionerRouter
    private weak var ui: IAirConditionerView?

    // MARK: - Init

    init(interactor: IAirConditionerInteractor,
         router: IAirConditionerRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IAirConditionerPresenter

extension AirConditionerPresenter: IAirConditionerPresenter {
    func viewDidLoad(ui: IAirConditionerView) {
        self.ui = ui
        self.ui?.toggleAirConditioner = { [weak self] in
            self?.interactor.toggleAirConditioner()
        }
        self.ui?.sliderDidChangeValue = { [weak self] newValue in
            self?.interactor.setTemprature(newValue)
        }
        self.ui?.sliderDidEndGesture = { [weak self] newValue in
            self?.interactor.sliderDidEndGesture(withValue: newValue)
        }
        self.interactor.loadInitData()
    }

    func saveData() {
        self.interactor.saveData()
    }
}

// MARK: - IAirConditionerInteractorOuter

extension AirConditionerPresenter: IAirConditionerInteractorOuter {
    func prepareView(airCoditioner: AirConditioner) {
        self.ui?.prepareView(airConditioner: airCoditioner)
    }

    func changeTempratureTo(_ tempratureLevel: Int) {
        self.ui?.changeSliderValueTo(tempratureLevel)
    }

    func reloadAirConditionerInfo(airConditioner: AirConditioner) {
        self.ui?.changeAirConditionerInfo(airConditioner: airConditioner)
    }
}
