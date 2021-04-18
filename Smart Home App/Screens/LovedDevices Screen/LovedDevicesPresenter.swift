//
//  LovedDevicesPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/18/21.
//

import Foundation

protocol ILovedDevicesPresenter {
    func reloadData()
    func viewDidLoad(ui: IMainView)
}

final class LovedDevicesPresenter {

    // MARK: - Properties

    private let interactor: ILovedDevicesInteractor
    private let router: ILovedDevicesRouter
    private weak var ui: IMainView?

    // MARK: - Init

    init(interactor: ILovedDevicesInteractor, router: ILovedDevicesRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ILovedDevicesPresenter

extension LovedDevicesPresenter: ILovedDevicesPresenter {
    func viewDidLoad(ui: IMainView) {
        self.ui = ui
        self.ui?.goToDeviceAt = { [weak self] indexPath in
            let dev = self?.interactor.getDevice(atIndexPath: indexPath)
            guard let device = dev else {
                assertionFailure("oops, can't get a deivce")
                return
            }
            self?.router.showDevice(device)
        }
        self.ui?.cellTappedAt = { [weak self] indexPath in
            self?.interactor.cellTappedAt(indexPath)
        }
        self.ui?.toggleLikedState = { [weak self] indexPath in
            self?.interactor.toggleIsLikedState(atIndexPath: indexPath)
        }
        self.interactor.loadInitData()
    }

    func reloadData() {
        self.interactor.reloadData()
    }
}

// MARK: - ILovedDevicesInteractorOuter

extension LovedDevicesPresenter: ILovedDevicesInteractorOuter {
    func reloadView(devices: [SmartHomeDevice]) {
        self.ui?.reloadView(devices: devices)
    }
}
