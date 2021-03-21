//
//  MainPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import Foundation

protocol IMainPresenter {
    func viewDidLoad(ui: IMainView)
}

final class MainPresenter {

    // MARK: - Properties

    private weak var ui: IMainView?
    private let interactor: IMainInteractor
    private let router: IMainRouter

    init(interactor: IMainInteractor, router: IMainRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IMainPresenter

extension MainPresenter: IMainPresenter {
    func viewDidLoad(ui: IMainView) {
        self.ui = ui
        self.interactor.loadInitData()
    }
}

// MARK: - IMainInteractorOuter

extension MainPresenter: IMainInteractorOuter {
    func prepareView(devices: [SmartHomeDevice]) {
        self.ui?.prepareView(devices: devices)
    }
}
