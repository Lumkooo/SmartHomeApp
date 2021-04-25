//
//  MainPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import Foundation

protocol IMainPresenter {
    func viewDidAppear(ui: IMainView)
    func goToMenu(delegate: IMenuDelegate)
    func moveContentBackAfterMenu()
    func userSignIn()
    func userSignOut()
    func addDeviceTapped()
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
        self.ui?.toggleLikedState = { [weak self] indexPath in
            self?.interactor.toggleIsLikedState(atIndexPath: indexPath)
        }
        self.interactor.loadInitData()
    }

    func goToMenu(delegate: IMenuDelegate) {
        self.ui?.moveCollectionViewOnLeft()
        self.router.showMenu(delegate: delegate)
    }

    func moveContentBackAfterMenu() {
        self.ui?.moveContentBackAfterMenu()
    }

    func userSignIn() {
        self.interactor.userSignIn()
    }

    func userSignOut() {
        self.interactor.userSignOut()
    }

    func addDeviceTapped() {
        self.interactor.addDeviceTapped()
    }
}

// MARK: - IMainInteractorOuter

extension MainPresenter: IMainInteractorOuter {
    func goToAddingDevice(delegate: IAddDeviceDelegate) {
        self.router.showAddingVC(delegate: delegate)
    }


    func reloadView(devices: [SmartHomeDevice]) {
        self.ui?.reloadView(devices: devices)
    }
}
