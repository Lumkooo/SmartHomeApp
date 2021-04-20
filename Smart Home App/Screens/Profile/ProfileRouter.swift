//
//  ProfileRouter.swift
//  FocusStartProject
//
//  Created by Андрей Шамин on 12/8/20.
//

import UIKit

protocol IProfileRouter {
    func showRegisterVC(delegate: ProfileDelegate)
    func showLoginVC(delegate: ProfileDelegate)
    func showAlertWithMessage(_ message: String)
}

final class ProfileRouter {
    weak var vc: UIViewController?
}

// MARK: - IProfileRouter

extension ProfileRouter: IProfileRouter {
    func showRegisterVC(delegate: ProfileDelegate){
        let registerVC = RegisterVCAssembly.createVC(delegate: delegate)
        registerVC.hidesBottomBarWhenPushed = true
        registerVC.navigationController?.navigationBar.prefersLargeTitles = false
        self.vc?.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func showLoginVC(delegate: ProfileDelegate) {
        let loginVC = LoginVCAssembly.createVC(delegate: delegate)
        loginVC.hidesBottomBarWhenPushed = true
        loginVC.navigationController?.navigationBar.prefersLargeTitles = false
        self.vc?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func showAlertWithMessage(_ message: String) {
        let alert = AlertAssembly.createSimpleAlert(withMessage: message)
        self.vc?.navigationController?.present(alert, animated: true)
    }
}
