//
//  RegisterVCAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import UIKit

enum RegisterVCAssembly {
    static func createVC(delegate: ProfileDelegate) -> UIViewController {
        let registerInteractor = RegisterInteractor(delegate: delegate)
        let registerRouter = RegisterRouter()
        let registerPresenter = RegisterPresenter(interactor: registerInteractor,
                                                  router: registerRouter)
        let registerViewController = RegisterViewController(presenter: registerPresenter)

        registerRouter.vc = registerViewController
        registerInteractor.presenter = registerPresenter

        return registerViewController
    }
}
