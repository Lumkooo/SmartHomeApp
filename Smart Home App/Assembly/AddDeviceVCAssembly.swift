//
//  AddDeviceVCAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/25/21.
//

import UIKit

enum AddDeviceVCAssembly {
    static func createVC(delegate: IAddDeviceDelegate) -> UIViewController {
        let interactor = AddDeviceInteractor(delegate: delegate)
        let router = AddDeviceRouter()
        let presenter = AddDevicePresenter(interactor: interactor, router: router)
        let viewController = AddDeviceViewController(presenter: presenter)

        router.vc = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
