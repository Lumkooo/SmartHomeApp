//
//  SendErrorRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

protocol ISendErrorRouter {
    func showThanksAlert()
}

final class SendErrorRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
}

// MARK: - ISendErrorRouter

extension SendErrorRouter: ISendErrorRouter {
    func showThanksAlert() {
        let alert = AlertAssembly.createSimpleAlert(withMessage: Localized("thanksForSendingError")) {
            self.vc?.navigationController?.popViewController(animated: true)
        }
        self.vc?.navigationController?.present(alert, animated: true)
    }
}
