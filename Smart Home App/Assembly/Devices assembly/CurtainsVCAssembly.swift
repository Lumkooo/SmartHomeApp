//
//  CurtainsVCAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/10/21.
//

import UIKit

enum CurtainsVCAssembly {
    static func createVC(curtains: Curtains, delegate: IReloadAfterRemovedDevice) -> UIViewController {
        let interactor = CurtainsInteractor(curtains: curtains, delegate: delegate)
        let router = CurtainsRouter()
        let presenter = CurtainsPresenter(interactor: interactor, router: router)
        let viewController = CurtainsViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController
        router.presenter = presenter

        return viewController
    }
}
