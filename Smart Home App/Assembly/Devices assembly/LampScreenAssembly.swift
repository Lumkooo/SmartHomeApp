//
//  LampScreenAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

enum LampScreenAssembly {
    static func createVC(lamp: Lamp, delegate: IReloadAfterRemovedDevice) -> UIViewController {
        let router = LampRouter()
        let interactor = LampInteractor(lamp: lamp, delegate: delegate)
        let presenter = LampPresenter(interactor: interactor, router: router)
        let viewController = LampViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController
        router.presenter = presenter

        return viewController
    }
}
