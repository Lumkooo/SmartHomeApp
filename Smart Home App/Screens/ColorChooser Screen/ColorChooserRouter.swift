//
//  ColorChooserRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

protocol IColorChooserRouter {
    func dismissVC()
}

final class ColorChooserRouter {

    // MARK: - Proeprties

    weak var vc: UIViewController?
}

// MARK: - IColorChooserRouter

extension ColorChooserRouter: IColorChooserRouter {
    func dismissVC() {
        self.vc?.dismiss(animated: false)
    }
}
