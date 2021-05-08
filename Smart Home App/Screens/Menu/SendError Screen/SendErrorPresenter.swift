//
//  SendErrorPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import Foundation

protocol ISendErrorPresenter {
    func viewDidLoad(ui: ISendErrorView)
}

final class SendErrorPresenter {

    // MARK: - Properties

    private let router: ISendErrorRouter
    private let interactor: ISendErrorInteractor
    private weak var ui: ISendErrorView?

    // MARK: - Init

    init(router: ISendErrorRouter, interactor: ISendErrorInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ISendErrorPresenter

extension SendErrorPresenter: ISendErrorPresenter {
    func viewDidLoad(ui: ISendErrorView) {
        self.ui = ui
    }
}

// MARK: - ISendErrorInteractorOuter

extension SendErrorPresenter: ISendErrorInteractorOuter {

}
