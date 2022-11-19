//
//  LampRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

protocol ILampRouter {
    func showDeviceInfo(forDevice device: SmartHomeDevice)
    func showRenameVC(forDevice device: SmartHomeDevice)
    func showDeleteAlert(forDevice device: SmartHomeDevice)
    func showChangeColorVC(delegate: ColorChooserDelegate)
    func showAlertWith(message: String)
    func dismissVC()
}


protocol ILampRouterOuter: AnyObject {
    func changeDeviceName(newName: String)
    func deleteDevice()
}

final class LampRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
    weak var presenter: ILampRouterOuter?
}

// MARK: - ILampRouter

extension LampRouter: ILampRouter {
    func showChangeColorVC(delegate: ColorChooserDelegate) {
        let vc = ColorChooserAssembly.createVC(delegate: delegate)
        vc.modalPresentationStyle = .overFullScreen
        self.vc?.navigationController?.present(vc, animated: false)
    }

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
