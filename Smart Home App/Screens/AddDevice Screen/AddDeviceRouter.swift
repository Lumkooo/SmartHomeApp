//
//  AddDeviceRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/25/21.
//

import UIKit

protocol IAddDeviceRouter {
    func showCodeError()
    func showNameError()
    func dismissVC()
}

final class AddDeviceRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
}

// MARK: - IAddDeviceRouter

extension AddDeviceRouter: IAddDeviceRouter {
    func showCodeError() {
        let alert = AlertAssembly.createSimpleAlert(withMessage: Localized("codeError"))
        self.vc?.navigationController?.present(alert, animated: true)
    }

    func showNameError() {
        let alert = AlertAssembly.createSimpleAlert(withMessage: Localized("nameError"))
        self.vc?.navigationController?.present(alert, animated: true)
    }

    func dismissVC() {
        self.vc?.navigationController?.popViewController(animated: true)
    }
}
