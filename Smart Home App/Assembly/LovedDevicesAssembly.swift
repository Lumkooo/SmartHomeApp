//
//  LovedDevicesAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/18/21.
//

import UIKit

enum LovedDevicesAssembly {
    static func createVC() -> LovedDevicesViewController {
        let router = LovedDevicesRouter()
        let interactor = LovedDevicesInteractor()
        let presenter = LovedDevicesPresenter(interactor: interactor, router: router)
        let viewController = LovedDevicesViewController(presenter: presenter)

        router.vc = viewController
        interactor.presenter = presenter

        return viewController
    }
}
