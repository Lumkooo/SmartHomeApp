//
//  MenuPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/17/21.
//

import Foundation

protocol IMenuPresenter {
    func viewDidLoad(ui: IMenuView)
    func viewDidAppear()
}

final class MenuPresenter {

    // MARK: - Properties

    private let interactor: IMenuInteractor
    private let router: IMenuRouter
    private weak var ui: IMenuView?

    // MARK: - Init

    init(interactor: IMenuInteractor, router: IMenuRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IMenuPresenter

extension MenuPresenter: IMenuPresenter {
    func viewDidLoad(ui: IMenuView) {
        self.ui = ui
        self.ui?.moveBackScreenContentBack = { [weak self] in
            self?.interactor.moveContentBackAfterMenu()
        }
        self.ui?.closeButtonTapped = { [weak self] in
            self?.router.dismissMenu()
        }
        self.ui?.getAppInfoTapped = { [weak self] in
            self?.interactor.showAppInfo()
            self?.router.dismissMenu()
        }

        self.ui?.sendErrorTapped = { [weak self] in
            self?.interactor.showSendError()
            self?.router.dismissMenu()
        }
    }

    func viewDidAppear() {
        self.ui?.slideView()
    }
}

// MARK: - IMenuInteractorOuter

extension MenuPresenter: IMenuInteractorOuter {

}
