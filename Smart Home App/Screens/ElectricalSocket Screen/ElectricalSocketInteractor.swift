//
//  ElectricalSocketInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import Foundation

protocol IElectricalSocketInteractor {
    func loadInitData()
    func getDeviceName() -> String
    func toggleState()
}

protocol IElectricalSocketInteractorOuter: AnyObject {
    func prepareView(electricalSocket: ElectricalSocket)
    func reloadState(_ newState: Bool)
}

final class ElectricalSocketInteractor {

    // MARK: - Properties

    weak var presenter: IElectricalSocketInteractorOuter?
    private let electricalSocket: ElectricalSocket

    // MARK: - Init

    init(electricalSocket: ElectricalSocket) {
        self.electricalSocket = electricalSocket
    }
}

// MARK: - IElectricalSocketInteractor

extension ElectricalSocketInteractor: IElectricalSocketInteractor {
    func loadInitData() {
        self.presenter?.prepareView(electricalSocket: self.electricalSocket)
    }

    func getDeviceName() -> String {
        return self.electricalSocket.name
    }

    func toggleState() {
        self.electricalSocket.toggleDevice()
        self.presenter?.reloadState(electricalSocket.isTurnedOn)
    }
}
