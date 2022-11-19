//
//  MainRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol IMainRouter {
    func showDevice(_ device: SmartHomeDevice, delegate: IReloadAfterRemovedDevice)
    func showMenu(delegate: IMenuDelegate)
    func showAddingVC(delegate: IAddDeviceDelegate)
    func showAppInfo()
    func showSendError()
}

final class MainRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
    private let devicesRouter = DevicesRouter()
}

// MARK: - IMainRouter

extension MainRouter: IMainRouter {
    func showDevice(_ device: SmartHomeDevice, delegate: IReloadAfterRemovedDevice) {
        guard let viewController = self.devicesRouter.getViewControllerFor(device: device, delegate: delegate) else {
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

    func showAddingVC(delegate: IAddDeviceDelegate) {
        let addDeviceVC = AddDeviceVCAssembly.createVC(delegate: delegate)
        self.vc?.navigationController?.pushViewController(addDeviceVC, animated: true)
    }

    func showAppInfo() {
        let appInfoVC = AppInfoVCAssembly.createVC()
        appInfoVC.hidesBottomBarWhenPushed = true
        self.vc?.navigationController?.pushViewController(appInfoVC, animated: true)
    }

    func showSendError() {
        let sendErrorVC = SendErrorVCAssembly.createVC()
        sendErrorVC.hidesBottomBarWhenPushed = true
        self.vc?.navigationController?.pushViewController(sendErrorVC, animated: true)
    }
}
