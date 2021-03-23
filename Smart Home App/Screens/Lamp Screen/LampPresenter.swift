//
//  LampPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import Foundation

protocol ILampPresenter {
    func viewDidLoad(ui: ILampView)
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
        
    }
}

// MARK: - ILampInteractorOuter

extension LampPresenter: ILampInteractorOuter {
    
}
