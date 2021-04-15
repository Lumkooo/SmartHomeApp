//
//  ProfileVCAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/31/21.
//

import UIKit

enum ProfileVCAssembly {
    static func createVC() -> UIViewController {
        let router = ProfileRouter()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(interactor: interactor, router: router)
        let viewController = ProfileViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController

        return viewController
    }
}
