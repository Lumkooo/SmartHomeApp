//
//  MainRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol IMainRouter {
    func showDevice(_ device: SmartHomeDevice)
    func showMenu(delegate: IMenuDelegate)
}

final class MainRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
    private let devicesRouter = DevicesRouter()
}

// MARK: - IMainRouter

extension MainRouter: IMainRouter {
    func showDevice(_ device: SmartHomeDevice) {
        guard let viewController = self.devicesRouter.getViewControllerFor(device: device) else {
            assertionFailure("oops, error occured")
            return
        }
        self.vc?.navigationController?.pushViewController(viewController, animated: true)
    }

    func showMenu(delegate: IMenuDelegate) {
        let menuVC = MenuAssembly.createVC(delegate: delegate)
        menuVC.modalPresentationStyle = .overFullScreen
        self.vc?.navigationController?.present(menuVC, animated: false)
    }
}
