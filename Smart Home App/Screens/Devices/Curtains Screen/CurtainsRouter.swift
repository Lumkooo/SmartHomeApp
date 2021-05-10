//
//  CurtainsRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/10/21.
//

import UIKit

protocol ICurtainsRouter {
    func showDeviceInfo(forDevice device: SmartHomeDevice)
    func showRenameVC(forDevice device: SmartHomeDevice)
    func showDeleteAlert(forDevice device: SmartHomeDevice)
    func showChangeColorVC(delegate: ColorChooserDelegate)
    func showAlertWith(message: String)
    func dismissVC()
}


protocol ICurtainsRouterOuter: AnyObject {
    func changeDeviceName(newName: String)
    func deleteDevice()
}

final class CurtainsRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
    weak var presenter: ICurtainsRouterOuter?
}

// MARK: - ICurtainsRouter

extension CurtainsRouter: ICurtainsRouter {
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
