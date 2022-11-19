//
//  MenuAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/17/21.
//

import UIKit

enum MenuAssembly {
    static func createVC(delegate: IMenuDelegate) -> UIViewController {
        let router = MenuRouter()
        let interactor = MenuInteractor(delegate: delegate)
        let presenter = MenuPresenter(interactor: interactor, router: router)
        let viewController = MenuViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController

        return viewController
    }
}
