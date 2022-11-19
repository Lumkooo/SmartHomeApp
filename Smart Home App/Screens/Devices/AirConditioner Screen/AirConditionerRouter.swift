//
//  AirConditionerRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/13/21.
//

import UIKit

protocol IAirConditionerRouter {
    func showDeviceInfo(forDevice device: SmartHomeDevice)
    func showRenameVC(forDevice device: SmartHomeDevice)
    func showDeleteAlert(forDevice device: SmartHomeDevice)
    func showAlertWith(message: String)
    func dismissVC()
}

protocol IAirConditionerRouterOuter: AnyObject {
    func changeDeviceName(newName: String)
    func deleteDevice()
}


final class AirConditionerRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
    weak var presenter: IAirConditionerRouterOuter?
}

// MARK: - IAirConditionerRouter

extension AirConditionerRouter: IAirConditionerRouter {
    func showDeviceInfo(forDevice device: SmartHomeDevice) {
        let alert = AlertAssembly.createDeviceInfoAlert(forDevice: device)
        self.vc?.present(alert, animated: true)
    }

    func showRenameVC(forDevice device: SmartHomeDevice) {
        let alert = AlertAssembly.createRenameDeviceAlert(forDevice: device) { (newName) in
            self.presenter?.changeDeviceName(newName: newName)
        }
        self.vc?.present(alert, animated: true)
    }

    func showDeleteAlert(forDevice device: SmartHomeDevice) {
        let alert = AlertAssembly.createDeleteDeviceAlert(forDevice: device) {
            self.presenter?.deleteDevice()
        }
        self.vc?.present(alert, animated: true)
    }

    func dismissVC() {
        self.vc?.navigationController?.popViewController(animated: true)
    }

    func showAlertWith(message: String) {
        let alert = AlertAssembly.createSimpleAlert(withMessage: message)
        self.vc?.present(alert, animated: true)
    }
}
