//
//  ElectricalSocketPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import Foundation

protocol IElectricalSocketPresenter {
    func getDeviceName() -> String
    func viewDidLoad(ui: IElectricalSocketView)
}

final class ElectricalSocketPresenter {

    // MARK: - Properties

    private let interactor: IElectricalSocketInteractor
    private let router: IElectricalSocketRouter
    private weak var ui: IElectricalSocketView?

    // MARK: - Init

    init(interactor: IElectricalSocketInteractor, router: IElectricalSocketRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IElectricalSocketPresenter

extension ElectricalSocketPresenter: IElectricalSocketPresenter {
    func viewDidLoad(ui: IElectricalSocketView) {
        self.ui = ui
        self.ui?.toggleButtonTapped = { [weak self] in
            self?.interactor.toggleState()
        }
        self.interactor.loadInitData()
    }

    func getDeviceName() -> String {
        return self.interactor.getDeviceName()
    }
}

// MARK: - IElectricalSocketInteractorOuter

extension ElectricalSocketPresenter: IElectricalSocketInteractorOuter {
    func reloadState(_ newState: Bool) {
        self.ui?.reloadState(newState)
    }

    func prepareView(electricalSocket: ElectricalSocket) {
        self.ui?.prepareView(electricalSocket: electricalSocket)
    }
}

