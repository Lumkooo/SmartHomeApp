//
//  MenuRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/17/21.
//

import UIKit

protocol IMenuRouter {
    func dismissMenu()
}

final class MenuRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
}

// MARK: - IMenuRouter

extension MenuRouter: IMenuRouter {
    func dismissMenu() {
        self.vc?.dismiss(animated: false, completion: nil)
    }
}
