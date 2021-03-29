//
//  ElectricalSocketAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import UIKit

enum ElectricalSocketAssembly {
    static func createVC(electricalSocket: ElectricalSocket) -> UIViewController {
        let interactor = ElectricalSocketInteractor(electricalSocket: electricalSocket)
        let router = ElectricalSocketRouter()
        let presenter = ElectricalSocketPresenter(interactor: interactor, router: router)
        let viewController = ElectricalSocketViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController

        return viewController
    }
}
