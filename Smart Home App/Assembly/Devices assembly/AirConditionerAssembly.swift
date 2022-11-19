//
//  AirConditionerAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/13/21.
//

import UIKit

enum AirConditionerAssembly {
    static func createVC(airConditioner: AirConditioner, delegate: IReloadAfterRemovedDevice) -> UIViewController {
        let router = AirConditionerRouter()
        let interactor = AirConditionerInteractor(airConditioner: airConditioner, delegate: delegate)
        let presenter = AirConditionerPresenter(interactor: interactor, router: router)
        let viewController = AirConditionerViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController
        router.presenter = presenter

        return viewController
    }
}
