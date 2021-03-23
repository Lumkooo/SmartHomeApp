//
//  MainRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol IMainRouter {
    func showDevice(_ device: SmartHomeDevice)
}

final class MainRouter {
    weak var vc: UIViewController?
}

// MARK: - IMainRouter

extension MainRouter: IMainRouter {
    func showDevice(_ device: SmartHomeDevice) {
        if device is Lamp {
            guard let lamp = device as? Lamp else {
                assertionFailure("Can't downcast device to lamp")
                return
            }
            let vc = LampScreenAssembly.createVC(lamp: lamp)
            self.vc?.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("this isn't lamp")
        }
    }
}
