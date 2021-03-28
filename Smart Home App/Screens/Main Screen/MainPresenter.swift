//
//  MainPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import Foundation

protocol IMainPresenter {
    func viewDidAppear(ui: IMainView)
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
    
    func viewDidAppear(ui: IMainView) {
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
        self.interactor.loadInitData()
    }
}

// MARK: - IMainInteractorOuter

extension MainPresenter: IMainInteractorOuter {
    func reloadView(devices: [SmartHomeDevice]) {
        self.ui?.reloadView(devices: devices)
    }
}
