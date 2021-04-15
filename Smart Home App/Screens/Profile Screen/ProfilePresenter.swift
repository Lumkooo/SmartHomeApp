//
//  ProfilePresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/31/21.
//

import Foundation

protocol IProfilePresenter {
    func viewDidLoad(ui: IProfileView)
}

final class ProfilePresenter {

    // MARK: - Properties

    private weak var ui: IProfileView?
    private let interactor: IProfileInteractor
    private let router: IProfileRouter

    // MARK: - Init

    init(interactor: IProfileInteractor, router: IProfileRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IProfilePresenter

extension ProfilePresenter: IProfilePresenter {
    func viewDidLoad(ui: IProfileView) {
        
    }
}

// MARK: - IProfileInteractorOuter

extension ProfilePresenter: IProfileInteractorOuter {
    
}
