//
//  LoginVCAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import UIKit

enum LoginVCAssembly {
    static func createVC(delegate: ProfileDelegate) -> UIViewController {
        let loginInteractor = LoginInteractor(delegate: delegate)
        let loginRouter = LoginRouter()
        let loginPresenter = LoginPresenter(interactor: loginInteractor,
                                            router: loginRouter)
        let loginViewController = LoginViewController(presenter: loginPresenter)

        loginRouter.vc = loginViewController
        loginInteractor.presenter = loginPresenter

        return loginViewController
    }
}
