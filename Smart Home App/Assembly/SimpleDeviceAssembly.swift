//
//  ElectricalSocketAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import UIKit

enum SimpleDeviceAssembly {
    static func createVC(device: SmartHomeDevice, delegate: IReloadAfterRemovedDevice) -> UIViewController {
        let interactor = SimpleDeviceInteractor(device: device, delegate: delegate)
        let router = SimpleDeviceRouter()
        let presenter = SimpleDevicePresenter(interactor: interactor, router: router)
        let viewController = SimpleDeviceViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController
        router.presenter = presenter

        return viewController
    }
}
