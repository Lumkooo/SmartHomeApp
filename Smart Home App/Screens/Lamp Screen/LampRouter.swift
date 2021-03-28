//
//  LampRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

protocol ILampRouter {
    func showChangeColorVC(delegate: ColorChooserDelegate)
}

final class LampRouter {
    weak var vc: UIViewController?
}

// MARK: - ILampRouter

extension LampRouter: ILampRouter {
    func showChangeColorVC(delegate: ColorChooserDelegate) {
        let vc = ColorChooserAssembly.createVC(delegate: delegate)
        vc.modalPresentationStyle = .overFullScreen
        self.vc?.navigationController?.present(vc, animated: false)
    }
}
