//
//  LovedDevicesRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/18/21.
//

import UIKit

protocol ILovedDevicesRouter {
    func showDevice(_ device: SmartHomeDevice)
}

final class LovedDevicesRouter {

    // MARK: - Properties
    
    weak var vc: UIViewController?
    private let devicesRouter = DevicesRouter()
}

// MARK: - ILovedDevicesRouter

extension LovedDevicesRouter: ILovedDevicesRouter {
    func showDevice(_ device: SmartHomeDevice) {
        guard let viewController = self.devicesRouter.getViewControllerFor(device: device) else {
            assertionFailure("oops, error occured")
            return
        }
        self.vc?.navigationController?.pushViewController(viewController, animated: true)
    }
}
