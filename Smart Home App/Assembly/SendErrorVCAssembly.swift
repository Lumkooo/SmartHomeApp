//
//  SendErrorVCAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

enum SendErrorVCAssembly {
    static func createVC() -> UIViewController {
        let router = SendErrorRouter()
        let interactor = SendErrorInteractor()
        let presenter = SendErrorPresenter(router: router, interactor: interactor)
        let viewController = SendErrorViewController(presenter: presenter)

        router.vc = viewController
        interactor.presenter = presenter

        return viewController
    }
}
