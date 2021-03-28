//
//  ColorChooserAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

enum ColorChooserAssembly {
    static func createVC(delegate: ColorChooserDelegate) -> UIViewController {
        let router = ColorChooserRouter()
        let interactor = ColorChooserInteractor(delegate: delegate)
        let presenter = ColorChooserPresenter(interactor: interactor, router: router)
        let viewController = ColorChooserViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController

        return viewController
    }
}
