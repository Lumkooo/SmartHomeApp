//
//  MainScreenAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

enum MainScreenAssembly {
    static func createVC(lovedDevicesDelegate: ILovedDevicesDelegate) -> MainViewController {

        let router = MainRouter()
        let interactor = MainInteractor(lovedDevicesDelegate: lovedDevicesDelegate)
        let presenter = MainPresenter(interactor: interactor, router: router)
        let viewController = MainViewController(presenter: presenter)

        router.vc = viewController
        interactor.presenter = presenter

        return viewController
    }
}
